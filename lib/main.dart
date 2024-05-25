import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:letterboxd_porto_3/app_color.dart';
import 'package:letterboxd_porto_3/controllers/getx_binding.dart';
import 'package:letterboxd_porto_3/views/film_detail_screen.dart';
import 'package:letterboxd_porto_3/views/main_screen.dart';
import 'package:letterboxd_porto_3/views/login_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/register_screen.dart';

void main() {
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const MainScreen(),
          binding: MainScreenBinding(),
        ),
        GetPage(name: '/film_detail', page: () => FilmDetailScreen(),)
      ],
    );
  }
}
