namespace cnma.type;

// Define the structure of the permissions object
type UserPermissions {
    canCreateCourse  : Boolean;
    canCreateArticle : Boolean;
    isAdmin          : Boolean;
}

// Define the response type for your function
type UserInfoResponse {
    ID          : UUID;
    fullName    : String;
    email       : String;
    avatar      : String;
    permissions : UserPermissions;
}
