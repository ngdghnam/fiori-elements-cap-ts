namespace cnma.knowledgesharing;

using {cnma.user as user} from './user';
using {cnma.common as common} from './common';

using {
    cuid,
    managed
} from '@sap/cds/common';


entity Article : cuid, managed {
    title      : String;
    summary    : LargeString;
    content    : LargeString;
    visibility : String enum {
        PUBLIC;
        PRIVATE;
        DEPARTMENT;
    };
    status     : String enum {
        Draft;
        Published;
        Archived;
    };

    category   : Association to common.Category;
    author     : Association to user.User; // Replaces 'createdBy' FK

    tags       : Composition of many ArticleTag
                     on tags.article = $self;
}

// Join entity for Many-to-Many
entity ArticleTag {
    key article : Association to Article;
    key tag     : Association to common.Tag;
}

// ----------------------------------------------------------------------------
// 4. Shared Interaction (Comments & Bookmarks)
// ----------------------------------------------------------------------------
entity Comment : cuid, managed {
    user       : Association to user.User;
    targetType : String enum {
        COURSE;
        ARTICLE;
    };
    targetId   : UUID;
    content    : LargeString;
}

entity Bookmark : cuid, managed {
    user       : Association to user.User;
    targetType : String enum {
        COURSE;
        ARTICLE;
    };
    targetId   : UUID;
}
