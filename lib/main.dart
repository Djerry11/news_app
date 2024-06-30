import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './src/routes/app_routes.dart';

Future main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      routerConfig: AppRoutes.router,
      themeMode: ThemeMode.light,
      theme: ThemeData(),
    );
  }
}
