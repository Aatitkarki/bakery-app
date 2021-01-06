import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:get_storage/get_storage.dart';

final _userKEY = "USER";

class AppUserState {
  AppUserState._();

  factory AppUserState() {
    return _instance;
  }
  static final _instance = AppUserState._();

  Log log = Log("AppUserState");
  final GetStorage box = GetStorage();

  LoginResponseModel _user;
  LoginResponseModel get user {
    log.d("\n");
    log.d(_user?.token ?? "No Token");
    log.d("\n");

    return _user;
  }

  bool get isLoggedIn => _user != null;

  saveUser(LoginResponseModel user) {
    if (user != null) {
      _user = user;
      box.write(_userKEY, user);
      log.s("User data stored successfully");
    } else
      throw "User cannot be null";
  }

  retrieveUser() {
    final rawUser = box.read(_userKEY);

    if (rawUser != null) _user = LoginResponseModel.fromJson(rawUser);
  }

  clear() {
    _user = null;
    box.erase();
  }
}
