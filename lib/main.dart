import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: scaffoldColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: scaffoldColor,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ground Fresh',
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: darkFontGrey),
            elevation: 0,
            backgroundColor: scaffoldColor,
          ),
          fontFamily: regular),
      //home: const LoginScreen(),
      home: const SplashScreen(),
    );
  }
}
