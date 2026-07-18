import { UserRepository } from "../repository/user.repository";
import { LearningHubRepository } from "../repository/learninghub.repository";
import { UserInfoResponse } from "#cds-models/cnma/type";

export class LearningHubService {
  constructor(
    private readonly userRepo: UserRepository,
    private readonly learningHubRepo: LearningHubRepository,
  ) {}

  async getUserInfo(userID: string, reqUser?: any): Promise<UserInfoResponse> {
    const user = await this.userRepo.findUserByID(userID);

    if (!user) {
      // Hardcoded fallback mock user for development
      return {
        ID: userID,
        fullName: "Nguyen Dang Hoai Nam",
        email: "nam.nguyen@conarum.com",
        avatar: "https://avatars.githubusercontent.com/u/4723114",
        permissions: {
          canCreateCourse: true,
          canCreateArticle: true,
          isAdmin: true,
        },
      };
    }

    const res: UserInfoResponse = {
      ID: user.ID,
      fullName: user.fullName,
      email: user.email,
      avatar: user.avatar,
      permissions: {
        canCreateCourse: true,
        canCreateArticle: true,
        isAdmin: true,
      },
    };

    return res;
  }

  async getCourseProgress(courseID: string, userID: string): Promise<number> {
    const lectures = await this.learningHubRepo.findLecturesByCourse(courseID);
    if (!lectures || lectures.length === 0) return 0;

    const completedLectures =
      await this.learningHubRepo.findCompletedLecturesByUser(courseID, userID);

    const progress = Math.round(
      (completedLectures.length / lectures.length) * 100,
    );
    return progress;
  }
}
