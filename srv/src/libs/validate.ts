import "reflect-metadata";
import { plainToInstance, ClassConstructor } from "class-transformer";
import { validate } from "class-validator";
import cds from "@sap/cds";

export async function validateDto<T extends object>(
  dtoClass: ClassConstructor<T>,
  data: unknown,
): Promise<T> {
  const instance = plainToInstance(dtoClass, data);
  const errors = await validate(instance, {
    whitelist: true, // strip unknown properties
    forbidNonWhitelisted: true, // reject if unknown props are sent
  });

  if (errors.length > 0) {
    const details = errors
      .map((e) => Object.values(e.constraints || {}).join(", "))
      .join("; ");
    // cds.error throws an OData-compliant error CAP will turn into a 400
    cds.error(400, details);
  }

  return instance;
}
