import 'package:hive/hive.dart';
import 'package:polymarq/authentication/models/response_models/login_response_model.dart';
import 'package:polymarq/providers/constants.dart';

class MyPref {
  MyPref._(); ///this is to prevent anyone from instantiating this object

  static Box<dynamic> box() {
    return Hive.box(StorageConstant.BOX_NAME);
  }


  static String get accessToken =>
      box().get(StorageConstant.ACCESS_TOKEN, defaultValue: '').toString();
  static set accessToken(String value) =>
      box().put(StorageConstant.ACCESS_TOKEN, value);

  static String get refreshToken =>
      box().get(StorageConstant.REFRESH_TOKEN, defaultValue: '').toString();
  static set refreshToken(String value) =>
      box().put(StorageConstant.REFRESH_TOKEN, value);

       static String get uuid =>
      box().get(StorageConstant.UUID, defaultValue: '').toString();
  static set uuid(String value) =>
      box().put(StorageConstant.UUID, value);
             static String get checkoutLink =>
      box().get(StorageConstant.checkoutLink, defaultValue: '').toString();
  static set checkoutLink(String value) =>
      box().put(StorageConstant.checkoutLink, value);


 

  ///User
  static User? get user {
    final value = box().get(StorageConstant.USER, defaultValue: null);
    if (value != null) {
      return userFromJson(value as String);
    }
    return null;
  }

  static set user(User? value) =>
      box().put(StorageConstant.USER, value != null ? userToJson(value) : null);

  ///profile picture
  static String get profilePicture => box().get('profilePicture', defaultValue: '').toString();
  static set profilePicture(String value) => box().put('profilePicture', value);

  ///call this to clear all hive boxes
  static Future<void> clearBoxes() async {
    await box().clear();
  }
}
