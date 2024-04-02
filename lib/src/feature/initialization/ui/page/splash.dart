// ignore_for_file: use_build_context_synchronously

import 'package:base_starter/src/app/router/router.dart';
import 'package:base_starter/src/common/utils/global_variables.dart';
import 'package:base_starter/src/core/assets/generated/assets.gen.dart';
import 'package:base_starter/src/core/resource/data/database/src/secure_storage.dart';
import 'package:base_starter/src/feature/auth/ui/page/auth.dart';
import 'package:base_starter/src/feature/home/ui/page/home.dart';
import 'package:flutter/material.dart';

part 'view/splash_model.dart';
part 'view/splash_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String name = "Splash";
  static const String routePath = "/splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fToast.init(navigatorKey.currentContext!);
      final tokenPair = await SecureStorageService.getToken();
      if (tokenPair != null && context.mounted) {
        context.pushReplacementNamed(HomePage.name);
      } else {
        context.pushReplacementNamed(AuthPage.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) => const _SplashView();
}