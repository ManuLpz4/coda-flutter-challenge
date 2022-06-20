import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logic/core/state.dart';
import 'logic/user/user_provider.dart';
import 'presentation/core/utils/routes.dart';
import 'presentation/core/utils/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      builder: (context, child) {
        return ProviderListener(
          onChange: (context, userState) {
            if (userState is Data) return _navigateToClients();
            if (userState is Initial) return _navigateToSignIn();
          },
          provider: userControllerProvider,
          child: child!,
        );
      },
    );
  }

  void _navigateToClients() {
    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/clients',
      (_) => false,
    );
  }

  void _navigateToSignIn() {
    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/sign_in',
      (_) => false,
    );
  }
}
