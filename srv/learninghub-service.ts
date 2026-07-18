import cds from "@sap/cds";
import LearningHubHandler from "./src/handler/learningHub.handler";

export class LEARNINGHUB_SRV extends cds.ApplicationService {
  async init() {
    await LearningHubHandler(this);

    await super.init();
  }
}
