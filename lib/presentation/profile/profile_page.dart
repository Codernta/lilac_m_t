import 'package:flutter/material.dart';
import 'package:lilac_mt/controller/profile/profile_provider.dart';
import 'package:lilac_mt/utilities/text_styles.dart';
import 'package:lilac_mt/widget/custom_widgets.dart';
import 'package:lilac_mt/widget/def_text_field.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProfileProvider profileProvider, child) => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            profileProvider.userDobController.clear();
            profileProvider.userEmailController.clear();
            profileProvider.userNameController.clear();
            return true;
          },
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                   Text(
                    'Profile',
                    style: primaryStyle,
                  ),
                  const SizedBox(height: 60),
                  TextFieldWidget(
                    controller: profileProvider.userNameController,
                    label: 'Name',
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: profileProvider.userEmailController,
                    label: 'Email',
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: profileProvider.userDobController,
                    readOnly: true,
                    label: 'Date of Birth',
                    suffix: const Icon(Icons.date_range),
                    onTap: () => profileProvider.setDateOfBirth(context),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 60 / 100,
                    child: CustomWidgets.submitButton(
                      'Save',
                      onTap: () => profileProvider.saveUserData(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
