import cds, { Service } from "@sap/cds";
import { LearningHubService } from "../service/learninghub.service";
import { UserRepository } from "../repository/user.repository";
import { LearningHubRepository } from "../repository/learninghub.repository";

export default async function LearningHubHandler(srv: Service) {
  const service = new LearningHubService(new UserRepository(), new LearningHubRepository());

  srv.on("getUserInfo", async (req: cds.Request) => {
    let userId = req.data.userId;
    if (!userId || userId === "current" || userId === "'current'" || userId === "'''current'''" || userId === "anonymous") {
      userId = req.user.id === "anonymous" ? "current" : req.user.id;
    }
    return await service.getUserInfo(userId, req.user);
  });

  srv.after("READ", "Course", async (each: any, req: cds.Request) => {
    if (each && typeof each === 'object' && 'ID' in each) {
      const userID = req.user.id === "anonymous" ? "current" : req.user.id;
      if (userID) {
        each.progress = await service.getCourseProgress(each.ID, userID);
      } else {
        each.progress = 0;
      }
    } else if (Array.isArray(each)) {
      const userID = req.user.id === "anonymous" ? "current" : req.user.id;
      if (userID) {
        await Promise.all(each.map(async (course: any) => {
          if (course && course.ID) {
            course.progress = await service.getCourseProgress(course.ID, userID);
          }
        }));
      }
    }
  });
}
