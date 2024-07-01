import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/common_widgets/custom_snackbar.dart';
import 'package:news_app/src/core/network/internet_service.dart';

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
    print('showSnack: $showSnack');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      routerConfig: AppRoutes.router,
      themeMode: ThemeMode.light,
      theme: ThemeData(),
      builder: (context, child) {
        print(
            'Widget is online rebuild: ${DateTime.now().millisecondsSinceEpoch}');

        final isOnline = ref.watch(connectivityNotifierProvider);
        print("isOnline changed: $isOnline");

        return Stack(
          children: [
            child!,
            if (!isOnline)
              CustomSnackbar(
                iconData: Icons.wifi_off,
                message: 'No Internet Connection',
                isVisible: showSnack,
                iconColor: Colors.red,
                onDismissed: () {
                  setState(() {
                    showSnack = !showSnack;
                  });
                },
              ),

            // print('Floating Action Button Pressed');
          ],
        );
      },
    );
  }
}
