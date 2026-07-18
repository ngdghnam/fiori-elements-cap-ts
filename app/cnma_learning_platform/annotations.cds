using LEARNINGHUB_SRV as service from '../../srv/learninghub-service';

annotate service.Course with @(
    UI.HeaderInfo: {
        TypeName: 'Course',
        TypeNamePlural: 'Courses',
        Title: { $Type: 'UI.DataField', Value: title },
        Description: { $Type: 'UI.DataField', Value: description }
    },
    // Main LineItem used for "Course Progress" card
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: title, Label: 'Course Title' },
        { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#Progress', Label: 'Progress' }
    ],
    UI.DataPoint #Progress: {
        Value: progress,
        TargetValue: 100,
        Visualization: #Progress,
        Title: 'Course Progress'
    },
    // Annotations for Latest Courses Card
    UI.LineItem #LatestCourses: [
        { $Type: 'UI.DataField', Value: title, Label: 'Course Title' },
        { $Type: 'UI.DataField', Value: difficulty, Label: 'Difficulty' }
    ],
    UI.SelectionVariant #LatestCourses: {
        SortOrder: [ { Property: createdAt, Descending: true } ]
    },
    // Annotations for Courses by Category Chart Card
    UI.Chart #CoursesByCategory: {
        ChartType: #Donut,
        Measures: ['ID'],
        Dimensions: ['category_ID'],
        MeasureAttributes: [{
            Measure: 'ID',
            Role: #Axis1
        }],
        DimensionAttributes: [{
            Dimension: 'category_ID',
            Role: #Category
        }]
    }
);

annotate service.LectureProgress with @(
    UI.HeaderInfo: {
        TypeName: 'Lecture Progress',
        TypeNamePlural: 'Lecture Progresses',
        Title: { $Type: 'UI.DataField', Value: lecture.title }
    },
    UI.LineItem #ContinueLearning: [
        { $Type: 'UI.DataField', Value: lecture.title, Label: 'Lecture Title' },
        { $Type: 'UI.DataField', Value: watchTime, Label: 'Watch Time (s)' }
    ],
    UI.SelectionVariant #ContinueLearning: {
        SelectOptions: [
            {
                PropertyName: completed,
                Ranges: [{ Sign: #I, Option: #EQ, Low: false }]
            }
        ],
        SortOrder: [ { Property: lastViewedAt, Descending: true } ]
    }
);

annotate service.Article with @(
    UI.HeaderInfo: {
        TypeName: 'Article',
        TypeNamePlural: 'Articles',
        Title: { $Type: 'UI.DataField', Value: title }
    },
    UI.LineItem #LatestArticles: [
        { $Type: 'UI.DataField', Value: title, Label: 'Article Title' },
        { $Type: 'UI.DataField', Value: author_ID, Label: 'Author' }
    ],
    UI.SelectionVariant #LatestArticles: {
        SortOrder: [ { Property: createdAt, Descending: true } ]
    }
);