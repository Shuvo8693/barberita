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
static String registerBarberUrl= '/api/v1/barber/add-barber';
static String verifyOtpUrl= '/api/v1/auth/verify-otp';
static String addBiometricUrl= '/api/v1/auth/add-device-id';
static String loginBiometricUrl= '/api/v1/auth/device-login';
static String verifyForgotOtpUrl(String userMail) =>  '/api/v1/user/verify-forget-otp?email=$userMail';
static String searchMechanicUrl(String service) =>  '/api/v1/mechanic/all?serviceName=$service';
static String barberDetailsUrl({String? barberId}) =>  '/api/v1/barber/get-barber-information-as-customer/$barberId';
static String barberReviewUrl({String? barberId}) =>  '/api/v1/review/barber-reviews/$barberId';
static String barberServiceUrl({String? barberId}) =>  '/api/v1/barber/barber-services?barberId=$barberId';
static String bookedServiceInfoUrl({String? barberId}) =>  '/api/v1/barber/barber-not-available/$barberId';
static String barberAddedServicesUrl({String? barberId}) =>  '/api/v1/barber/barber-services?barberId=$barberId';
static String barberServiceToggleUrl({String? serviceId}) =>  '/api/v1/barber/change-service-status/$serviceId';
static String bookingDetailsUrl({String? bookingGroupId}) =>  '/api/v1/booking/get-booking-details/$bookingGroupId';
static String orderConfirmationUrl({String? bookingGroupId}) =>  '/api/v1/booking/update-booking-status/$bookingGroupId';
static String markAsDoneUrl({String? bookingGroupId}) =>  '$baseUrl/api/v1/booking/mark-as-done/$bookingGroupId';  // manual request method
static String bookingStatusUrl({String? status}) =>  '/api/v1/booking/$status';
static String updateBarberServiceUrl({String? serviceId}) =>  '/api/v1/barber/update-service/$serviceId';
static String userReviewUrl({String? userId}) =>  '/api/v1/review/barber-reviews/$userId';
static String termsPolicyUrl({String? termsAndPolicy}) =>  '/api/v1/$termsAndPolicy';
static String allMechanicUrl({int? currentPage, int? limit}) =>  '/api/v1/mechanic/all?currentPage=$currentPage&limit=$limit';
static String nearbyBarbersUrl({String? name, bool? isNearby}) =>  '/api/v1/barber/get-barbers?search=$name&nearby=$isNearby';

static String phoneSendUrl= '/api/v1/auth/forget-password';
static String logOutUrl= '/api/v1/auth/logout';
static String verifyEmailWithOtpUrl= '/api/v1/auth/verify-email';
static String resendOtpUrl= '/api/v1/auth/resend-otp';
static String logInUrl= '/api/v1/auth/login';
static String resetPasswordUrl= '/api/v1/auth/reset-password';
static String topRatedBarberUrl= '/api/v1/barber/top-rated-barber';
static String favouriteBarberUrl= '/api/v1/favorite/get-favorite-barber';
static String addBookingUrl = '/api/v1/booking/add-booking';
static String allServicesUrl = '/api/v1/barber/all-services';
static String addReviewUrl = '/api/v1/review/add-review';
static String profileUrl = '/api/v1/auth/get-profile-info';
static String customerProfileUpdateUrl = '/api/v1/auth/profile-update';
static String barberProfileUpdateUrl = '/api/v1/barber/update-barber';
static String serviceActivationStatusUrl = '/api/v1/barber/update-available-status';
static String addBarberServiceUrl = '/api/v1/barber/create-service';
static String notificationUrl = '/api/v1/notification';
static String badgeCountUrl = '/api/v1/notification/badge-count';


}