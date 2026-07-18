import { Service } from "../libs/decorator";
import { UserRepository } from "../repository/user.repository";

@Service("LearningHubService")
export class LearningHubService {
  constructor(private readonly userRepo: UserRepository) {}

  async getUserInfo(userId: string) {
    const user = await this.userRepo.getUser(userId);
    return user;
  }
}
