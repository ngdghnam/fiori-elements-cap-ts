namespace cnma.learninghub;

using {cnma.user as user} from './user';
using {cnma.common as common} from './common';

using {
    cuid,
    managed
} from '@sap/cds/common';


// ----------------------------------------------------------------------------
// 2. Learning Module (Courses, Sections, Lectures, Resources)
// ----------------------------------------------------------------------------
entity Course : cuid, managed {
    title             : String;
    description       : LargeString;
    thumbnail         : String;
    estimatedDuration : Integer; // in minutes
    difficulty        : String enum {
        Beginner;
        Intermediate;
        Advanced;
    };
    language          : String;
    status            : String enum {
        Draft;
        Published;
        Archived;
    };

    // Associations
    category          : Association to common.Category;
    author            : Association to user.User; // Replaces 'createdBy' FK

    // Compositions (Lifecycle bound to Course)
    tags              : Composition of many CourseTags
                            on tags.course = $self;
    sections          : Composition of many Section
                            on sections.course = $self;
}

// Join entity for Many-to-Many
entity CourseTags {
    key course : Association to Course;
    key tag    : Association to common.Tag;
}

entity Section : cuid {
    course   : Association to Course;
    title    : String;
    orderNo  : Integer;

    lectures : Composition of many Lecture
                   on lectures.section = $self;
}

entity Lecture : cuid {
    section     : Association to Section;
    title       : String;
    description : LargeString;
    duration    : Integer;
    orderNo     : Integer;

    resources   : Composition of many Resource
                      on resources.lecture = $self;
    notes       : Composition of many LectureNote
                      on notes.lecture = $self;
    progress    : Composition of many LectureProgress
                      on progress.lecture = $self;
}

entity Resource : cuid {
    lecture  : Association to Lecture;
    type     : String enum {
        VIDEO;
        PDF;
        IMAGE;
        ARTICLE;
        LINK;
        QUIZ;
    };
    title    : String;
    url      : String;
    content  : LargeString;
    fileName : String;
    mimeType : String;
    fileSize : Integer;
    orderNo  : Integer;
}

entity LectureNote : cuid, managed {
    lecture : Association to Lecture;
    user    : Association to user.User;
    title   : String;
    content : LargeString;
}

entity LectureProgress : cuid {
    lecture      : Association to Lecture;
    user         : Association to user.User;
    completed    : Boolean;
    watchTime    : Integer;
    lastViewedAt : Timestamp;
}
