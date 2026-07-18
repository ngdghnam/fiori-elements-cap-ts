import cds, { Service } from "@sap/cds";
import { container } from "../libs/container";
import { LearningHubService } from "../service/learninghub.service";

export default async function LearningHubHandler(srv: Service) {
  const service = container.resolve(LearningHubService);

  srv.on("getUserInfo", async (req: cds.Request) => {
    const userId = req.data.userId || req.user.id;
    return await service.getUserInfo(userId);
  });

  srv.after("READ", "Course", async (each: any, req: cds.Request) => {
    if (each && typeof each === 'object' && 'ID' in each) {
      const userID = req.user.id;
      if (userID) {
        each.progress = await service.getCourseProgress(each.ID, userID);
      } else {
        each.progress = 0;
      }
    } else if (Array.isArray(each)) {
      const userID = req.user.id;
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
