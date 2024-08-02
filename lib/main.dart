
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_mt/presentation/splash/splash_screen.dart';
import 'package:lilac_mt/controller/home/home_provider.dart';
import 'package:lilac_mt/controller/profile/profile_provider.dart';
import 'package:lilac_mt/controller/auth/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDBJUiOgyx3N67dMnCn8wbHEytQGgyE-_4',
        appId: '1:282757741661:android:0023985f85cd34c8a7e1b4',
        messagingSenderId: '282757741661',
        projectId: 'lilacmt-5cb74'),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false)
        .checkUserLogged(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProfileProvider profileProvider, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lilac mt',
        theme: profileProvider.darkModeEnabled
            ? ThemeData.dark()
            : ThemeData.light(useMaterial3: true),
        home: const SplashScreen(),
      ),
    );
  }
}

