type Constructor<T = any> = new (...args: any[]) => T;

class Container {
  private instances = new Map<Constructor, any>();
  private registry = new Map<string, Constructor>();
  private resolving = new Set<Constructor>();

  register(token: string, target: Constructor) {
    this.registry.set(token, target);
  }

  resolve<T>(target: Constructor<T>): T {
    if (this.instances.has(target)) {
      return this.instances.get(target);
    }

    if (this.resolving.has(target)) {
      throw new Error(
        `Circular dependency detected while resolving "${target.name}"`,
      );
    }
    this.resolving.add(target);

    const paramTypes: Constructor[] =
      Reflect.getMetadata("design:paramtypes", target) || [];
    const dependencies = paramTypes.map((dep) => this.resolve(dep));

    const instance = new target(...dependencies);
    this.instances.set(target, instance);
    this.resolving.delete(target);

    return instance;
  }

  getByToken<T>(token: string): T {
    const target = this.registry.get(token);
    if (!target) throw new Error(`No service registered for token "${token}"`);
    return this.resolve(target);
  }
}

export const container = new Container();
