import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:letterboxd_porto_3/app_color.dart';
import 'package:letterboxd_porto_3/controllers/getx_binding.dart';
import 'package:letterboxd_porto_3/firebase_options.dart';
import 'package:letterboxd_porto_3/views/film_detail_screen.dart';
import 'package:letterboxd_porto_3/views/main_screen.dart';
import 'package:letterboxd_porto_3/views/login_screen.dart';
import 'package:letterboxd_porto_3/views/review_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/register_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Letterboxd',
      initialRoute: '/onboarding',
      defaultTransition: Transition.native,
      theme: ThemeData(
          useMaterial3: true,
          extensions: const [
            AppColors(
                primaryCr: Color(0xFF1F1D36),
                secondaryCr: Color(0xFFE9A6A6),
                accentCr: Color(0xFF9C4A8B),
                whiteCr: Color(0xFFFFFFFF))
          ]),
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingScreen(),
        ),
        GetPage(
          name: '/login',
          binding: LoginBinding(),
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/register',
          binding: RegisterBinding(),
          page: () => const RegisterScreen(),
        ),
        GetPage(
          name: '/home',
          binding: MainScreenBinding(),
          page: () => const MainScreen(),
        ),
        GetPage(
          name: '/film_detail',
          page: () => const FilmDetailScreen(),
        ),
        GetPage(
          name: '/add_review',
          binding: ReviewScreenBinding(),
          page: () => const ReviewScreen(),
        )
      ],
    );
  }
}
