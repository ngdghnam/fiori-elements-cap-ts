import { Injectable } from "../libs/decorator";
import { User } from "#cds-models/cnma/user";
import cds from "@sap/cds";

@Injectable()
export class UserRepository {
  async findUserByID(userId: string): Promise<User> {
    const { User } = cds.entities("cnma.user");

    const user = await SELECT.one.from(User).where({
      ID: userId,
    });

    return user;
  }
}
