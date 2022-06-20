import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/user/user_provider.dart';
import '../core/widgets/coda_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: userControllerProvider,
      onChange: (_, __) {},
      child: const Scaffold(
        body: Center(
          child: CodaLogo(),
        ),
      ),
    );
  }
}
