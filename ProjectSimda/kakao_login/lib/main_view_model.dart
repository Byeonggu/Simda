import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login/social_login.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLoggedIn = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLoggedIn = await _socialLogin.login();
    if(isLoggedIn) {
      user = await UserApi.instance.me();
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLoggedIn = false;
    user = null;
  }

  Future signup(String path, String nickname) async {
    await _socialLogin.signup(path, nickname);
  }
}