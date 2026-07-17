// lib/decorators.ts
import "reflect-metadata";
import { container } from "./container";

export function Service(token?: string): ClassDecorator {
  return (target: any) => {
    const name = token || target.name;
    container.register(name, target);
    Reflect.defineMetadata("cap:service-token", name, target);
  };
}

export function Injectable(): ClassDecorator {
  // Just marks a class as DI-eligible (no registration needed
  // if it's only ever injected, never resolved by token)
  return (target: any) => {
    Reflect.defineMetadata("injectable", true, target);
  };
}
