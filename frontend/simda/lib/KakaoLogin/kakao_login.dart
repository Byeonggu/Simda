import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:simda/KakaoLogin/social_login.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:simda/models/UserDto.dart';

import '../store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? baseUrl = dotenv.env['BASE_URL'];
class KakaoLogin implements SocialLogin {
  final storage = const FlutterSecureStorage();
  final store = Store();

  static String ip = "$baseUrl";

  Future<void> saveStorage(Map<String, dynamic> map) async {

    map.forEach((key, value) {
      if (value is String) {
        storage.write(key: key, value: value);
      } else {
        String stringValue = json.encode(value);
        storage.write(key: key, value: stringValue);
      }
    });
  }

  @override
  Future<int> login() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("logs");
    ref.push().set({
      'key' : (await KakaoSdk.origin)
    });
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken? token;
      if (isInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
          await ref.push().set({
            'info' : '카카오톡 : 카카오 - flutter 로그인 성공'
          });
        }catch(e){
          await ref.push().set({
            'error': e.toString()
          });
        }
      } else {
        try{
          token = await UserApi.instance.loginWithKakaoAccount();
          await ref.push().set({
            'info' : '카카오 계정 : 카카오 - flutter 로그인 성공'
          });
        }catch(e){
          await ref.push().set({
            'error': e.toString()
          });
        }
      }
        try {
          store.saveAccessToken(token!);

          final url = Uri.parse("$ip/user/login/kakao");
          final response = await http.post(url,
              headers: {"Content-Type": "application/json"},
              body: json.encode({
                'accessToken': token.accessToken,
              }));

          saveStorage(jsonDecode(response.body));
          if (response.statusCode == 200) {
            // print("로그인 성공!");
            await ref.push().set({
              'info' : 'flutter - backend 로그인 성공',
              'email' : await storage.read(key:'email'),
              'nickname' : await storage.read(key: 'nickname')
            });
            return 1;
          } else if (response.statusCode == 202) {
            await ref.push().set({
              'info': 'flutter - backend 통신 성공 회원가입 요청',
              'email' : await storage.read(key:'email')
            });
            return 0;
          }
          return -1;
        } catch (e) {
          await ref.push().set({
            'error': e.toString()
          });
          print(e);
          return -1;
        }
    } catch (e) {
      await ref.push().set({
        'error': e.toString()
      });
      return -1;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      await UserApi.instance.unlink();
      storage.deleteAll();
      store.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> signup(String path, String nickname) async {
    try {
      Dio dio = Dio();
      var url = "$ip/user/";

      String? email = await storage.read(key: "email");

      UserDto userDto = UserDto(
          bio: '',
          userId: 0,
          email: email ?? '',
          nickname: nickname,
          profileImg: '',
          userRole: 0);

      FormData formData = FormData.fromMap({
        'imgfile': await MultipartFile.fromFile(path, filename: 'profile.jpg'),
        'email': userDto.email,
        'nickname': userDto.nickname,
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      saveStorage(response.data);
      String? storeUid = await storage.read(key:"userId");
      String? storeEmail = await storage.read(key: "email");
      String? storeProfileImg = await storage.read(key: "profileImg");
      String? storeNickname = await storage.read(key: "nickname");
      DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(storeUid!);
      await ref.set({
        "nickname": storeNickname,
        "userEmail" : storeEmail,
        "profileImg": storeProfileImg,
      });

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
