import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/kakao_login.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.env['NATIVE_APP_KEY'],
  );

  final kakaoLogin = KakaoLogin();
  bool isLogined = await kakaoLogin.login();

  runApp(MyApp(isLogined: isLogined));
}

class MyApp extends StatelessWidget {
  final bool isLogined;

  MyApp({required this.isLogined});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(isLogined: isLogined),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isLogined;

  MyHomePage({Key? key, required this.isLogined}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            '${widget.isLogined}',
            style: TextStyle(color: Colors.black, fontSize: 32),
          )
        ],
      ),
    );
  }
}
