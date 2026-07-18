import { Service } from "../libs/decorator";
import { UserRepository } from "../repository/user.repository";
import { UserInfoResponse } from "#cds-models/cnma/type";

@Service("LearningHubService")
export class LearningHubService {
  constructor(private readonly userRepo: UserRepository) {}

  async getUserInfo(userID: string): Promise<UserInfoResponse> {
    const user = await this.userRepo.findUserByID(userID);

    const res: UserInfoResponse = {
      ID: user.ID,
      fullName: user.fullName,
      email: user.email,
    };

    return res;
  }
}
