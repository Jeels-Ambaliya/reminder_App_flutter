import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app_flutter/views/detail_page.dart';
import 'package:reminder_app_flutter/views/home_page.dart';
import 'package:reminder_app_flutter/views/splash_screen.dart';
import 'package:reminder_app_flutter/views/update_data.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'controllers/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'Splash_Page',
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          routes: {
            'Home_Page': (context) => const Home_Page(),
            'Splash_Page': (context) => const SplashScreen(),
            'Detail_Page': (context) => const DetailPAge(),
            'Update_Page': (context) => const UpdatePage(),
          },
        );
      },
    );
  }
}
