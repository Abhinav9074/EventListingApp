import 'package:event_listing_app/core/navigation/router_provider.dart';
import 'package:event_listing_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(390, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Jakarta',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'Jakarta'),
            displayMedium: TextStyle(fontFamily: 'Jakarta'),
            displaySmall: TextStyle(fontFamily: 'Jakarta'),
            headlineLarge: TextStyle(fontFamily: 'Jakarta'),
            headlineMedium: TextStyle(fontFamily: 'Jakarta'),
            headlineSmall: TextStyle(fontFamily: 'Jakarta'),
            titleLarge: TextStyle(fontFamily: 'Jakarta'),
            titleMedium: TextStyle(fontFamily: 'Jakarta'),
            titleSmall: TextStyle(fontFamily: 'Jakarta'),
            bodyLarge: TextStyle(fontFamily: 'Jakarta'),
            bodyMedium: TextStyle(fontFamily: 'Jakarta'),
            bodySmall: TextStyle(fontFamily: 'Jakarta'),
            labelLarge: TextStyle(fontFamily: 'Jakarta'),
            labelMedium: TextStyle(fontFamily: 'Jakarta'),
            labelSmall: TextStyle(fontFamily: 'Jakarta'),
          ),
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
