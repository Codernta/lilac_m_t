import 'package:flutter/material.dart';
import 'package:lilac_mt/controller/profile/profile_provider.dart';
import 'package:lilac_mt/presentation/auth/auth_page.dart';
import 'package:lilac_mt/presentation/home/home_page.dart';
import 'package:lilac_mt/widget/custom_widgets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              if (Provider.of<ProfileProvider>(context, listen: false)
                  .isUserLoggedIn) {
                return const HomePage();
              } else {
                return const AuthenticationPage();
              }
            }));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Hero(
                tag: 'logo',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/lilac_logo.jpg',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomWidgets.stoppedAnimationProgress(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }
}
