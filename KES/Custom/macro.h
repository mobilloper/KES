//
//  macro.h
//
//  Created by matata on 9/2/15.
//  Copyright (c) 2015 matata. All rights reserved.
//

#ifndef travel_macro_h

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SCREEN_HEIGHT   self.view.frame.size.height
#define SCREEN_WIDTH    self.view.frame.size.width
#define METERS_PER_MILE 1609.344
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define USER_ROLE_VALUE  [[NSUserDefaults standardUserDefaults] valueForKey:@"user_role"]
#define IS_STUDENT       [USER_ROLE_VALUE isEqualToString:@"Student"] || ([@"Parent/Guardian" rangeOfString:USER_ROLE_VALUE].location != NSNotFound)

#define POST_REQUEST    @"POST"
#define GET_REQUEST     @"GET"
#define MAIN_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define MAXFIELDLENGTH 30

#define BASE_URL1        @"http://kilmartin.test.ibplatform.ie/"
#define BASE_URL        @"http://kilmartin.uat.ibplatform.ie/"
#define LOGIN_API       @"api/user/login"
#define SIGNUP_API      @"api/user/register"
#define FORGOTPWD_API   @"api/user/forgotpw"
#define PROFILE_API     @"api/user/profile"
#define NEWS_LIST       @"api/news/list"
#define BOOK_SEARCH     @"api/bookings/search2"
#define TIME_TABLE      @"api/contacts3/timetable"
#define ANALYTICS       @"api/contacts3/analytics"
#define NEXT_COUNTDOWN  @"api/contacts3/next_countdown"
#define CONTACT_DETAIL  @"api/contacts3/details"
#define CONTACT_COUNTRY @"api/contacts3/countries"
#define CONTACT_COUNTY  @"api/contacts3/counties"
#define CONTACT_NATIONAL @"api/contacts3/nationalities"
#define CONTACT_SCHOOK  @"api/contacts3/schools"
#define CONTACT_FAMILIY_MEMBERS  @"api/contacts3/family_members"
#define SEND_FEEDBACK   @"api/contacts3/send_feedback"
#define CONTACT_US      @"api/contacts3/send_contact_us"
#define PREFERENCE_TYPE @"api/contacts3/preference_types"
#define NOTIFICATION_TYPE @"api/contacts3/notification_types"
#define SCHEDULE_DETAIL @"api/schedules/details?id="
#define COURSE_DETAIL   @"api/courses/details?id="
#define COURSE_TOPICS   @"api/courses/topics"
#define COURSE_LOCATIONS  @"api/courses/locations"
#define COURSE_SUBJECTS @"api/courses/subjects"
#define COURSE_CATEGORY @"api/courses/categories"
#define COURSE_YEAR     @"api/courses/years"
#define COURSE_ACADEMIC @"api/courses/academic_years"
#define USER_LIST       @"api/user/list"
#define USER_LOGINAS    @"api/user/login_as"
#define USER_LOGINBACK  @"api/user/login_back"
#define PAGE_CONTENT    @"api/pages/details"
#define APP_SETTINGS    @"api/settings/variables"
#define CALENDAR_EVENT  @"api/calendar/events"
#define USER_ROLES      @"api/user/roles"
#define USER_ROLE       @"api/user/role"
#define TRAINER_ANALYTICS @"api/contacts3/trainer_analytics"
#define RC_TIMESLOTS      @"api/rollcall/timeslots"
#define RC_STUDENTS       @"api/rollcall/students"
#define RC_STUDENT_UPDATE @"api/rollcall/student_update"
#define RC_DATES          @"api/rollcall/dates"
#define INVITE_MEMBER     @"api/contacts3/invite_member"
#define UPLOAD_AVATAR     @"api/user/upload_avatar"

#define CREATE_BOOK_URL @"available-results.html"
#define HELP_URL        @"http://www.kes.ie/help.html"
#define ABOUT_URL       @"http://www.kes.ie/history"
#define KES_BOARD       @"https://kesboard.herokuapp.com/"
#define PRIVACY_POLICY  @"privacy-policy.html"
#define TERMS_SERVICE   @"terms-of-use.html"

#define PROFILE_UPDATED @"Your profile has been updated!"
#define ERROR_MSG       @"An error occurred. Please try again later"
#define NETWORK_ERROR   @"Please check your network status"
#define KEY_LOGGEDIN    @"loggedin"
#define KEY_LAUNCHED    @"launched"
#define KEY_REMEMBER    @"rememberme"
#define KEY_USERID      @"userid"
#define KEY_EMAIL       @"email"
#define KEY_PASSWORD    @"password"
#define KEY_FIRSTNAME   @"firstname"
#define KEY_LASTNAME    @"lastname"
#define KEY_PHONE       @"phone"
#define KEY_ADDRESS     @"address"
#define KEY_EIRCODE     @"eircode"
#define KEY_AVATAR      @"avatar"
#define KEY_SUPER_USER  @"super_user"
#define KEY_REGISTERED  @"registered"
#define KEY_SHAKE_APP   @"ShakeToSendAppFeedback"
#define BUILD_MODE      @"build_mode"

#define NOTIFICATION_LOGIN     @"LoginNotification"
#define NOTIFICATION_SIGNUP    @"SignupNotification"
#define NOTIFICATION_FORGOT    @"ForgotPwdNotification"
#define NOTIFICATION_QUESTION  @"QuestionNotification"
#define NOTIFICATION_GO_HOME   @"GoHomeNotification"
#define NOTIFICATION_LOGOUT    @"LogoutNotification"
#define NOTIFICATION_SETTINGS  @"SettingsNotification"
#define NOTIFICATION_UPBOOK    @"ViewUpBookNotification"
#define NOTIFICATION_VIEWEVENT @"ViewEventNotification"
#define NOTIFICATION_LOGINAS   @"LoginAsNotification"
#define NOTI_UPDATE_PROFILE    @"UpdateProfile"
#define NOTI_SEARCH_PAST_EVENT @"SearchPastEvent"
#define NOTI_TAP_LOGO          @"TapLogoNotification"
#define NOTI_GO_BOOK           @"GoBookNotification"
#define NOTI_RETRIEVE_FEED       @"RetrieveFeed"
#define NOTI_RETRIEVE_TIMETABLE  @"RetrieveTimeTable"
#define NOTI_GO_TIMETABLE        @"GoTimeTable"
#define NOTI_RETRIEVE_ANALYTICS  @"RetrieveAnalytics"
#define NOTI_SETTING_USERINFO    @"DisplaySettingUserInfo"
#define NOTIFICATION_SEARCH_BOOK @"SearchBookNotification"
#define NOTI_CLASS_DETAIL        @"ClassDetail"
#define NOTI_BOOK_DETAIL         @"BookingDetail"
#define NOTI_PROFILE             @"MyProfile"
#define NOTI_NOTIFICATIONS       @"MyNotifications"
#define NOTI_HELP                @"HelpPage"
#define NOTI_FEEDBACK            @"FeedbackPage"
#define NOTI_PREFERENCES         @"PreferencePage"
#define NOTI_MESSAGES            @"Messages"
#define NOTI_CONTACTUS           @"ContactUspage"
#define NOTI_SUBJECTS            @"MySubject"
#define NOTI_BETATESTER          @"BetaTester"
#define NOTI_SHAREWITHFRIENDS    @"ShareWithFriends"
#define NOTI_RATEUS              @"RateUs"
#define NOTI_USER_MANAMGE        @"UserManagePage"

#define NOTI_GO_PROFILE          @"go_profil"
#define NOTI_GO_PROFILE1         @"go_profil1"
#define NOTI_SELECT_INDEX        @"selected_index"
#define NOTI_SELECT_INDEX1       @"selected_index1"
#define NOTI_BLACKVIEW_SHOW      @"blackView_show"
#define NOTI_BLACKVIEW_HIDE      @"blackView_hide"
#define HIDE_BLACKVIEW_SUPER     @"blackView_hide_super"

// ----- Eduction predefine ------

#define EDU_SELECTED             @"edu_selected"
#define EDU_SELECTED_VALUE       @"edu_selected_value"
#define EDU_ACCOUNTING           @"edu_accounting"
#define EDU_APPLIED_MATHS        @"edu_applied_maths"
#define EDU_BIOLOGY              @"edu_biology"
#define EDU_CHEMISTRY            @"edu_chemistry"
#define EDU_DCG                  @"edu_dcg"
#define EDU_ENGLISH              @"edu_english"
#define EDU_GEOGRAPHY            @"edu_geography"
#define EDU_HISTORY              @"edu_history"
#define EDU_HPAT                 @"edu_hpat"
#define EDU_LCVP                 @"edu_lcvp"
#define EDU_MUSIC                @"edu_music"
#define EDU_RELIGION             @"edu_religion"
#define EDU_SPANISH              @"edu_spanish"
#define EDU_TECH_GRAPHICS        @"edu_tech_graphics"

#define NOTI_SHOW_SUB_BLACK      @"show_sub_black"
#define NOTI_HIDE_SUB_BLACK      @"hide_sub_black"
// -------
#define NOTI_SHOW_CAMERAVIEW      @"show_cameraview"
#define NOTI_SELECT_PROFILE_PHOTO @"select_profile_photo"
// ----- Todo predefine ------
#define TODO_LIST_IMAGE         @"todo_list_image"
#define TODO_LIST_TITLE         @"todo_list_title"
#define TODO_LIST_TIME          @"todo_list_time"
#define TODO_LIST_TYPE          @"todo_list_type"
#define TODO_LIST_LOCATION      @"todo_list_location"
#define TODO_LIST_SUBJECT       @"todo_list_subject"
#define TODO_LIST_ACCOUNTNAME   @"todo_list_accountname"
#define TODO_LIST_DAY           @"todo_list_day"
#define TODO_LIST_MORE          @"todo_list_more"
#define TODO_CREATE             @"todo_create"

// -------

#define NOTI_SESSIONED_BOOK      @"SessionChangedBook"
#define NOTI_SESSIONED_ATTENDANCE @"SessionChangedAttendance"
#define NOTI_ATTENDANCE_UPDATE   @"AttendanceUpdated"

#define APP_STORE_ID 912632260

#define kJVFieldFontSize 16.0f
#define kJVFieldFloatingLabelFontSize 11.0f
#define PageMenuOptionSelectionIndicatorHeight 7
#define PageMenuOptionMenuItemFont 21.0f
#define PageMenuOptionMenuHeight 45.0

#define COLOR_PRIMARY    0x00c6ee
#define COLOR_SECONDARY  0x12387f
#define COLOR_THIRD      0xb8d12f
#define COLOR_GRAY       0x787878
#define COLOR_FONT       0x303030

#endif
