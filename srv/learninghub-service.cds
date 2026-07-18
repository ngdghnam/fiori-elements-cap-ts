using {cnma.learninghub as learninghub} from '../db/schema/learninghub';
using {cnma.knowledgesharing as knowledgesharing} from '../db/schema/knowledgesharing';
using {cnma.user as user} from '../db/schema/user';
using {cnma.common as common} from '../db/schema/common';
using {cnma.type as type} from '../db/schema/type';


service LEARNINGHUB_SRV @(path: 'api/cnma/LEARNINGHUB_SRV') {

    // Expose entities
    entity Course          as projection on learninghub.Course {
        *,
        virtual null as progress : Integer
    };
    entity Section         as projection on learninghub.Section;
    entity Lecture         as projection on learninghub.Lecture;
    entity Resource        as projection on learninghub.Resource;
    entity LectureNote     as projection on learninghub.LectureNote;
    entity LectureProgress as projection on learninghub.LectureProgress;

    // Knowledge Sharing
    entity Article         as projection on knowledgesharing.Article;
    entity ArticleTag      as projection on knowledgesharing.ArticleTag;
    entity Comment         as projection on knowledgesharing.Comment;
    entity Bookmark        as projection on knowledgesharing.Bookmark;

    // Common
    entity Category        as projection on common.Category;
    entity Tag             as projection on common.Tag;

    // Users
    entity User            as projection on user.User;

    function getUserInfo(userId: String) returns type.UserInfoResponse;
}
