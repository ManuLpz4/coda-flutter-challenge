import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../domain/clients/client.dart';
import '../../client/client_page.dart';
import '../../clients/clients_page.dart';
import '../../sign_in/sign_in_page.dart';
import '../../splash/splash_page.dart';
import 'slide_page_route.dart';

class AppRoutes {
  const AppRoutes._();

  static Widget _builder(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return const SplashPage();
      case '/clients':
        return const ClientsPage();
      case '/client':
        return ClientPage(client: settings.arguments as Client?);
      case '/sign_in':
        return const SignInPage();
      default:
        return const SignInPage();
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (_) => _builder(settings),
        settings: settings,
      );
    } else {
      return SlidePageRoute(
        builder: (_) => _builder(settings),
        settings: settings,
      );
    }
  }
}
