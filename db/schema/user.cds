namespace cnma.user;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity User : cuid, managed {
    fullName : String(200);
    email    : String(100);
    avatar   : String(100);
}
