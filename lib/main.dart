import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/common_widgets/connection_errors/custom_snackbar.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/theme/domain/dark_theme.dart';

import './src/routes/app_routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool showSnack = true;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: darkThemeData,
        duration: const Duration(seconds: 2),
        builder: (context, myTheme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            routerConfig: AppRoutes.router,
            darkTheme: darkThemeData,
            // themeMode: themeMode,
            theme: myTheme,
            builder: (context, child) {
              final isOnline = ref.watch(connectivityNotifierProvider);

              return ThemeSwitchingArea(
                child: Builder(builder: (context) {
                  return Stack(
                    children: [
                      child!,
                      if (!isOnline)
                        CustomSnackbar(
                          iconData: Icons.wifi_off,
                          message: 'No Internet Connection',
                          isVisible: !isOnline,
                          iconColor: Colors.red,
                          onDismissed: () {
                            // setState(() {
                            //   showSnack = !showSnack;
                            // });
                          },
                        ),

                      // print('Floating Action Button Pressed');
                    ],
                  );
                }),
              );
            },
          );
        });
  }
}
