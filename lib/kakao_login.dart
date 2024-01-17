import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLogin {
  Future<bool> login() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        User user = await UserApi.instance.me();
        print(user.id);
        print(user.kakaoAccount?.profile?.nickname);

        print(tokenInfo);
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        return true;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
          return false;
        } else {
          print('토큰 정보 조회 실패 $error');
          return false;
        }

        try {
          // 카카오계정으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공 ${token.accessToken}');
        } catch (error) {
          print('로그인 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');
        return true;
      } catch (error) {
        print('로그인 실패 $error');
        return false;
      }
    }
  }
}
