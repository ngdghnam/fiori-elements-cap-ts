using LEARNINGHUB_SRV as service from '../../srv/learninghub-service';

annotate service.Tag with @(
    UI.HeaderInfo : {
        TypeName       : 'Tag',
        TypeNamePlural : 'Tags',
        Title          : {
            $Type : 'UI.DataField',
            Value : name
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : description
        }
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Tag Name'
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description'
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            Label : 'Created At'
        }
    ],
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneralInfo'
        }
    ],
    UI.FieldGroup #GeneralInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : 'Tag Name'
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : 'Description'
            }
        ]
    }
);
