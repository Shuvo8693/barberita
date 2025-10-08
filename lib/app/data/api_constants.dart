class ApiConstants{
/// google maps

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String estimatedTimeUrl="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";
   /// App Url
    static String baseUrl="https://faisal8083.merinasib.shop";
    static String imageBaseUrl="https://faisal8083.merinasib.shop";
    static String socketUrl="https://faisal8083.merinasib.shop";


///>>>>>>>>>>>>>>>>>>>>>>>>>>> Api End point >>>>>>>>>>>>>>>>>>>

static String registerUrl= '/api/v1/auth/register';
static String verifyOtpUrl= '/api/v1/auth/verify-otp';
static String verifyForgotOtpUrl(String userMail) =>  '/api/v1/user/verify-forget-otp?email=$userMail';
static String searchMechanicUrl(String service) =>  '/api/v1/mechanic/all?serviceName=$service';
static String allMechanicUrl({int? currentPage, int? limit}) =>  '/api/v1/mechanic/all?currentPage=$currentPage&limit=$limit';

static String phoneSendUrl= '/api/v1/auth/forget-password';
static String verifyEmailWithOtpUrl= '/api/v1/auth/verify-email';
static String resendOtpUrl= '/api/v1/auth/resend-otp';
static String logInUrl= '/api/v1/auth/login';
static String resetPasswordUrl= '/api/v1/user/reset-password';
static String changePasswordUrl= '/api/v1/user/change-password';

}