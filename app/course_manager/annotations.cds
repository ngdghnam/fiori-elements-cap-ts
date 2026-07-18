using LEARNINGHUB_SRV as service from '../../srv/learninghub-service';

annotate service.Course with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : thumbnail,
            Label : 'Thumbnail'
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Course Title'
        },
        {
            $Type : 'UI.DataField',
            Value : category_ID,
            Label : 'Category'
        },
        {
            $Type : 'UI.DataField',
            Value : difficulty,
            Label : 'Difficulty'
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Status'
        }
    ],
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneralInfo'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Tags',
            Target : 'tags/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Sections',
            Target : 'sections/@UI.LineItem'
        }
    ],
    UI.FieldGroup #GeneralInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title'
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : 'Description'
            },
            {
                $Type : 'UI.DataField',
                Value : estimatedDuration,
                Label : 'Estimated Duration (mins)'
            },
            {
                $Type : 'UI.DataField',
                Value : difficulty,
                Label : 'Difficulty'
            },
            {
                $Type : 'UI.DataField',
                Value : language,
                Label : 'Language'
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'Status'
            },
            {
                $Type : 'UI.DataField',
                Value : thumbnail,
                Label : 'Thumbnail URL'
            }
        ]
    }
);

annotate service.CourseTags with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : tag_ID,
            Label : 'Tag'
        }
    ]
);

annotate service.CourseTags with {
    tag @Common.ValueList: {
        CollectionPath : 'Tag',
        Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : tag_ID,
                ValueListProperty : 'ID'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name'
            }
        ]
    }
};

annotate service.Section with @(
    UI.HeaderInfo : {
        TypeName       : 'Section',
        TypeNamePlural : 'Sections',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        }
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : orderNo,
            Label : 'Order'
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Section Title'
        }
    ],
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#SectionInfo'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Lectures',
            Target : 'lectures/@UI.LineItem'
        }
    ],
    UI.FieldGroup #SectionInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title'
            },
            {
                $Type : 'UI.DataField',
                Value : orderNo,
                Label : 'Order'
            }
        ]
    }
);

annotate service.Lecture with @(
    UI.HeaderInfo : {
        TypeName       : 'Lecture',
        TypeNamePlural : 'Lectures',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        }
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : orderNo,
            Label : 'Order'
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Lecture Title'
        },
        {
            $Type : 'UI.DataField',
            Value : duration,
            Label : 'Duration (mins)'
        }
    ],
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#LectureInfo'
        }
    ],
    UI.FieldGroup #LectureInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title'
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : 'Description'
            },
            {
                $Type : 'UI.DataField',
                Value : duration,
                Label : 'Duration (mins)'
            },
            {
                $Type : 'UI.DataField',
                Value : orderNo,
                Label : 'Order'
            }
        ]
    }
);
