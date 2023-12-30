import 'package:flutter/material.dart';
import 'package:polymarq/authentication/view/screens/auth_add_payment.dart';
import 'package:polymarq/authentication/view/screens/bottom_nav_bar.dart';
import 'package:polymarq/authentication/view/screens/config_password.dart';
import 'package:polymarq/authentication/view/screens/email_forgot_passsword.dart';
import 'package:polymarq/authentication/view/screens/email_forgot_password_otp.dart';
import 'package:polymarq/authentication/view/screens/email_login.dart';
import 'package:polymarq/authentication/view/screens/email_otp.dart';
import 'package:polymarq/authentication/view/screens/email_signup.dart';
import 'package:polymarq/authentication/view/screens/new_password.dart';
import 'package:polymarq/authentication/view/screens/onboarding_screen.dart';
import 'package:polymarq/authentication/view/screens/personal_info_screen.dart';
import 'package:polymarq/authentication/view/screens/phone_no_forget_password.dart';
import 'package:polymarq/authentication/view/screens/phone_no_forgor_password_otp.dart';
import 'package:polymarq/authentication/view/screens/phone_no_new_password.dart';
import 'package:polymarq/authentication/view/screens/phoneno_login.dart';
import 'package:polymarq/authentication/view/screens/phoneno_otp.dart';
import 'package:polymarq/authentication/view/screens/phoneno_signup.dart';
import 'package:polymarq/authentication/view/screens/work_info_screen.dart';
import 'package:polymarq/routes/app_page_route.dart';
import 'package:polymarq/settings/view/screen/add_payment.dart';
import 'package:polymarq/settings/view/screen/application_status.dart';
import 'package:polymarq/settings/view/screen/bank_accont.dart';
import 'package:polymarq/settings/view/screen/change_password_email..dart';
import 'package:polymarq/settings/view/screen/change_password_phoneno.dart';
import 'package:polymarq/settings/view/screen/delete_account.dart';
import 'package:polymarq/settings/view/screen/delete_account2.dart';
import 'package:polymarq/settings/view/screen/language.dart';
import 'package:polymarq/settings/view/screen/linked_account.dart';
import 'package:polymarq/settings/view/screen/notification.dart';
import 'package:polymarq/settings/view/screen/personal_info.dart';
import 'package:polymarq/settings/view/screen/security.dart';
import 'package:polymarq/technicians/home_screen/view/screens/my_product_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/place_in_shop_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/product_category_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/scheduled_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/search_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/shop_tools_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/technician_dashboard_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/technician_profile.dart';
import 'package:polymarq/technicians/home_screen/view/screens/tool_share_screen.dart';

class AppRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();

  //authentication
  static const configPasswordPage = '/config-password';
  static const emailForgotPasswordPage = '/email-forgot-password';
  static const emailForgotPassswordOtpPage = '/email-forgot-password-otp';
  static const newPasswordPage = '/new-password-page';
  static const emailLoginPage = '/email-login';
  static const emailOtpPage = '/email-otp';
  static const emailSignupPage = '/email-signup';
  static const forgetPasswordPage = '/forgot-password';
  static const onboardingPage = '/onboarding';
  static const personalInfoPage = '/personal-info';
  static const phonenoForgotPasswordPage = '/phoneno-forgot';
  static const phonenoLoginPage = '/phoneno-login';
  static const phoneNoOtpPage = '/phone-otp';
  static const phonenoSignupPage = '/phoneno-signup';
  static const workInfoPage = '/work-info';
  static const authPaymentPage = '/auth-payment';
 static const forgotPhoneOTPPage = '/forgot-phone-otp';
  //settings
  static const applicationStatusPage = '/application-status';
  static const changePasswordEmailPage = '/change-password-email';
  static const changePasswordPhoneNoPage = '/change-password-phoneno';
  static const verifyPasswordEmail = '/verifyEmail';
  static const verifyPasswordPhoneNo = '/verifyPhoneNo';
  static const deleteAccountPage = '/delete-account';
  static const deleteAccount2Page = '/delete-account2';
  static const languagePage = '/language';
  static const linkedAccountPage = '/linked-account';
  static const notificationPage = '/notification';
  static const securityPage = '/security';
  static const addPaymentPage = '/add-payment';
  static const bankAccountPage = '/bank-account';
  static const personalInformationPage = '/personal-information';
static const phoneNoPasswordPage = '/phone-no-newpassord';
  //home
  static const bottomNavBar = '/bottom-nav-bar';

  //technicians
  static const jobDetailsPage = '/job-details';
  static const myProductPage = '/my-product';
  static const notificationsPage = '/notifications';
  static const placeInShopage = '/place-in-shop';
  static const productCategoriesPage = '/product-categories';
  static const scheduledPage = '/schedule';
  static const searchPage = '/search';
  static const shopToolsPage = '/shop-tools';
  static const shopTools2Page = '/shop-tools2';
  static const technicianDashboard = '/technician-dashboard';
  static const technicianProfile = '/technician-profile';
  static const toolShareDetailsPage = '/tool-share-details';
  static const toolSharePage = '/tool-share';
  static const toolDetailsPage = '/tool-details';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case configPasswordPage:
        return AppPageRouteBuilder(
          navigateTo: const ConfigPasswordScreen(),
        );
      case emailForgotPasswordPage:
        return AppPageRouteBuilder(
          navigateTo: const EmailForgetPasswordScreen(),
        );
      case emailLoginPage:
        return AppPageRouteBuilder(
          navigateTo: const EmailLoginScreen(),
        );
      case emailOtpPage:
        return AppPageRouteBuilder(
          navigateTo: EmailOtpScreen(),
        );
      case emailForgotPassswordOtpPage:
        return AppPageRouteBuilder(
          navigateTo: EmailForgotPasswordOtpScreen(),
        );
      case newPasswordPage:
        return AppPageRouteBuilder(
          navigateTo: const NewPasswordScreen(),
        );

      case emailSignupPage:
        return AppPageRouteBuilder(
          navigateTo: const EmailSignupScreen(),
        );
      case authPaymentPage:
        return AppPageRouteBuilder(
          navigateTo: AuthAddPayment(),
        );
      case onboardingPage:
        return AppPageRouteBuilder(
          navigateTo: const OnboardingScreen(),
        );
      case personalInfoPage:
        return AppPageRouteBuilder(
          navigateTo: const PersonalInfoScreen(),
        );
      case phonenoForgotPasswordPage:
        return AppPageRouteBuilder(
          navigateTo: const PhoneNoForgetPasswordScreen(),
        );
      case phonenoLoginPage:
        return AppPageRouteBuilder(
          setting: settings,
          navigateTo: const PhoneNoLoginScreen(),
        );
      case personalInformationPage:
        return AppPageRouteBuilder(
          setting: settings,
          navigateTo: const PersonalInfomationScreen(),
        );

      case phoneNoOtpPage:
        return AppPageRouteBuilder(
          navigateTo: PhoneNoOtpScreen(),
        );
      case phonenoSignupPage:
        return AppPageRouteBuilder(
          navigateTo: const PhoneNoSignupScreen(),
        );
      case workInfoPage:
        return AppPageRouteBuilder(
          navigateTo: const WorkInfoScreen(),
        );
      case bankAccountPage:
        return AppPageRouteBuilder(
          navigateTo: const BankAccountScreen(),
        );
      case bottomNavBar:
        return MaterialPageRoute(
          builder: (context) => const BottomNavBarScreen(),
        );

      case applicationStatusPage:
        return AppPageRouteBuilder(navigateTo: const ApplicationStatusScreen());

      case changePasswordEmailPage:
        return AppPageRouteBuilder(
          navigateTo: const ChangePasswordEmailScreen(),
        );
         case forgotPhoneOTPPage:
        return AppPageRouteBuilder(
          navigateTo:  PhoneNoForgotPasswordOtpScreen(),
        );
      case addPaymentPage:
        return AppPageRouteBuilder(
          navigateTo: AddPayment(),
        );
          case phoneNoPasswordPage:
        return AppPageRouteBuilder(
          navigateTo: const PhoneNoNewPasswordScreen(),
        );
      case changePasswordPhoneNoPage:
        return AppPageRouteBuilder(
          navigateTo: const ChangePasswordPhoneNoScreen(),
        );
      case deleteAccount2Page:
        return AppPageRouteBuilder(navigateTo: const DeleteAccount2Screen());
      case deleteAccountPage:
        return AppPageRouteBuilder(navigateTo: const DeleteAccountScreen());
      case linkedAccountPage:
        return AppPageRouteBuilder(navigateTo: const LinkedAccount());
      case notificationPage:
        return AppPageRouteBuilder(navigateTo: const NotificationScreen());
      case languagePage:
        return AppPageRouteBuilder(navigateTo: const LanguageScreen());
      case securityPage:
        return AppPageRouteBuilder(navigateTo: const SecurityScreen());

      case searchPage:
        return AppPageRouteBuilder(navigateTo: const SearchScreen());
      case myProductPage:
        return AppPageRouteBuilder(navigateTo: const MyProductScreen());
      case notificationsPage:
        return AppPageRouteBuilder(navigateTo: const NotificationScreen());
      case placeInShopage:
        return AppPageRouteBuilder(navigateTo: const PlaceInShopScreen());
      case productCategoriesPage:
        return AppPageRouteBuilder(navigateTo: const ProductCategoryScreen());
      case scheduledPage:
        return AppPageRouteBuilder(navigateTo: const ScheduledScreen());
      case shopToolsPage:
        return AppPageRouteBuilder(navigateTo: const ShopToolsScreen());
      // case shopTools2Page:
      //   return AppPageRouteBuilder(navigateTo: const ShoppTools2Screen());
      case technicianDashboard:
        return AppPageRouteBuilder(navigateTo: const TechnicianDashboard());
      case technicianProfile:
        return AppPageRouteBuilder(navigateTo: const TechnicianProfile());
      // case toolShareDetailsPage:
      //   return AppPageRouteBuilder(navigateTo:  ToolShareDetailsScreen());
      case toolSharePage:
        return AppPageRouteBuilder(navigateTo: const ToolShareScreen());
      // case toolDetailsPage:
      //   return AppPageRouteBuilder(navigateTo: const ToolsDetailsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
