import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );

      Hive.init((await getApplicationDocumentsDirectory()).path);

      await Future.wait([
        Hive.openBox('user'),
      ]);

      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };

      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
