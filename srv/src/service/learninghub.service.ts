import { Service } from "../libs/decorator";
import { UserRepository } from "../repository/user.repository";

@Service("LearningHubService")
export class LearningHubService {
  constructor(private readonly userRepo: UserRepository) {}

  async getUserInfo(userID: string) {
    const user = await this.userRepo.findUserByID(userID);
    return user;
  }
}
