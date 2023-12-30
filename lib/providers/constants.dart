// ignore_for_file: constant_identifier_names

class ApiConstant {
  ApiConstant._(); //this is to prevent anyone from instantiating this object
  static const String BASE_URL = 'https://dev.polymarqbackend.com/api/v1/';

  //auth
  static const String REGISTER = 'auth/register/technician/';
  static const String REGISTER_WITH_PHONE = 'auth/register/technician/phone';
  static const String LOGIN = 'auth/login/';
  static const String LOGOUT = 'auth/logout/';
  static const String VERIFY = 'auth/verify/';
  static const String VERIFY_PHONE = 'auth/phone-verification/verify/';
  static const String RESEND_PHONE_VERIFICATION =
      'auth/phone-verification/initiate/';
  static const String REFRESH_TOKEN = 'auth/token/refresh/';
  static const String PASSWORD_RESET = 'auth/password-reset/';
  static const String PASSWORD_RESET_CONFIRM = 'auth/password-reset/confirm/';
  static const String PASSWORD_RESET_VALIDATE_TOKEN =
      'auth/password-reset/validate-token/';
  static const String PHONENO_PASSWORD_RESET = 'auth/phone/password-reset/';
  static const String PHONENO_PASSWORD_RESET_CONFIRM =
      'auth/phone/password-reset/confirm/';
  static const String PHONENO_PASSWORD_RESET_VALIDATE_TOKEN =
      'auth/phone/password-reset/validate-token/';
  static const String GET_NOTIFICATION = 'notifications/';
  static const String UPDATE_PROFILE = 'technicians/profile/';
  static const String CREATE_TOOLS = 'tools/create/';
  static const String GET_CATEGORY = 'tools/categories/';
  static const String ALL_TOOLS = 'tools/';
  static const String TOOLS_COUNT = 'tools/counts/';
  static const String GET_USER = 'technicians/profile/';
  static const String RENT_TOOL = 'tools/rent-requests/';
  static const String JOB_REQUEST = 'job/requests/';
  static const String UPDATE_PROFILE_PICTURE = 'user/profile-picture/';
  static const String TOOL_PURCHASE = 'tools/purchase/initiate';
  static const String NEGOTIATE_TOOL = 'tools/negotiate/';
  static const String NEGOTIATE_TOOL_RESPONSE = 'tools/negotiate/response/';
  static const String GET_BANKS = 'payments/banks/list/';
  static const String BANK_ACCOUNT =
      'payments/technician-bank-accounts/create/';
  //jobs
  static const String GET_JOBS = 'job/';
  static const String ACCEPT_DECLINE_JOB = 'job/ping/accept-or-decline/';
}

class StorageConstant {
  StorageConstant._(); //this is to prevent anyone from instantiating this object

  static const String BOX_NAME = 'polymarq_hive';

  //auth
  static const String ACCESS_TOKEN = 'accessToken';
  static const String REFRESH_TOKEN = 'refreshToken';

  //user
  static const String USER = 'user';

  static const String UUID = 'uuid';

  static const String checkoutLink = 'authorizationUrl';
}
