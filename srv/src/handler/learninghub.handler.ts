import cds, { Service } from "@sap/cds";
import { container } from "../libs/container";
import { LearningHubService } from "../service/learninghub.service";

export default async function LearningHubHandler(srv: Service) {
  const service = container.resolve(LearningHubService);

  srv.on("getUserInfo", async (req: cds.Request) => {
    return await service.getUserInfo(req.data);
  });
}
