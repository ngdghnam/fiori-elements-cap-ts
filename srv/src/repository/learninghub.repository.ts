import cds from "@sap/cds";

export class LearningHubRepository {
  async findAllCourses() {
    const { Course } = cds.entities("cnma.learninghub");
  }

  async findLecturesByCourse(courseID: string) {
    const { Lecture } = cds.entities("cnma.learninghub");
    return await SELECT.from(Lecture).where({
      "section.course_ID": courseID,
    });
  }

  async findCompletedLecturesByUser(courseID: string, userID: string) {
    const { LectureProgress } = cds.entities("cnma.learninghub");
    return await SELECT.from(LectureProgress).where({
      "lecture.section.course_ID": courseID,
      user_ID: userID,
      completed: true,
    });
  }
}
