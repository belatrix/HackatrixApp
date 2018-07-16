const String BASE_URL = "https://bxevents.herokuapp.com:443";
//Event
const String API_UPCOMING_EVENT_LIST = BASE_URL + "/event/upcoming/list/";
const String API_EVENT_LIST = BASE_URL + "/event/list/";
const String API_EVENT_MEETING_LIST = BASE_URL + "/event/meeting/list/";
const String API_EVENT_REGISTER_ATTENDANCE = BASE_URL + "/event/register/attendance/";

String API_EVENT_IDEA_LIST(int eventId) => BASE_URL + "/event/$eventId/idea/list/";

String API_EVENT_IDEA_VOTES(int eventId) => BASE_URL + "/event/$eventId/idea/vote/";

//User
const String API_USER_AUTHENTICATE = BASE_URL + "/user/authenticate/";
const String API_USER_CREATE = BASE_URL + "/user/create/";
const String API_USER_LOGOUT = BASE_URL + "/user/logout/";
const String API_USER_PROFILE = BASE_URL + "/user/profile/";
const String API_USER_RECOVER = BASE_URL + "/user/recover/";
const String API_USER_UPDATE = BASE_URL + "/user/update/";
const String API_USER_UPDATE_PASSWORD = BASE_URL + "/user/update/password/";
