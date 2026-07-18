namespace cnma.common;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Category : cuid, managed {
    name        : String(100);
    description : String(500);
}

entity Tag : cuid, managed {
    name : String(500);
}
