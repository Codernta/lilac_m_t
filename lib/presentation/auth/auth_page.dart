import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lilac_mt/controller/auth/auth_provider.dart';
import 'package:lilac_mt/utilities/text_styles.dart';
import 'package:lilac_mt/widget/custom_widgets.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, AuthProvider authProvider, child) =>
              SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 105,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/lilac_logo.jpg',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 43,
                    ),
                    TextField(
                      controller: authProvider.phoneTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        hintText: "Enter Phone number",
                        hintStyle: primaryStyle,
                        prefix: Text(
                          "+91",
                          style: primaryStyle),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (authProvider.view == PageMode.otp)
                      TextField(
                        controller: authProvider.otpTextController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          hintText: "Enter OTP",
                          hintStyle: primaryStyle
                        ),
                      ),
                    const SizedBox(height: 30),
                    CustomWidgets.submitButton(
                      authProvider.resendButtonText,
                      onTap: authProvider.resendOtp
                          ? () => authProvider.resendOTPPressed(context)
                          : null,
                      bgColor: authProvider.resendOtp ? null : Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    CustomWidgets.submitButton(
                      authProvider.view == PageMode.phone
                          ? 'Send OTP'
                          : "Verify OTP",
                      onTap: () => authProvider.view == PageMode.phone
                          ? authProvider.enteredSubmitButton(context)
                          : authProvider.verifyOTP(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum PageMode { phone, otp }
