using LEARNINGHUB_SRV as service from '../../srv/learninghub-service';

annotate service.Course with @(
    UI.HeaderInfo: {
        TypeName: 'Course',
        TypeNamePlural: 'Courses',
        Title: { $Type: 'UI.DataField', Value: title },
        Description: { $Type: 'UI.DataField', Value: description }
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: title, Label: 'Course Title' },
        { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#Progress', Label: 'Progress' }
    ],
    UI.DataPoint #Progress: {
        Value: progress,
        TargetValue: 100,
        Visualization: #Progress,
        Title: 'Course Progress'
    }
);