import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/settings/screens/about_us.dart';
import 'package:leafloom_admin/view/settings/screens/pricacy_policy.dart';
import 'package:leafloom_admin/view/settings/screens/terms_and_conditions.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       firebase.signOut();
        //     },
        //     icon: const Icon(
        //       Icons.logout_sharp,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: 9,
              child: Container(
                decoration: const BoxDecoration(
                  // gradient: gcolor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                height: 240,
                width: 350,
                child: Column(
                  children: [
                    AccountTile(
                      icon: Icons.privacy_tip,
                      name: 'Privacy and Policy',
                      voidCallback: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PrivacyPolicyDialog();
                          },
                        );
                      },
                    ),
                    AccountTile(
                      icon: Icons.file_copy,
                      name: 'Terms and Conditions',
                      voidCallback: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const TermsAndConditionsDialog();
                          },
                        );
                      },
                    ),
                    AccountTile(
                      icon: CupertinoIcons.info_circle_fill,
                      name: 'About Us',
                      voidCallback: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AboutUsDialog();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 160,
        ),
        const SizedBox(height: 150),
      ],
    );
  }
}

// ignore: must_be_immutable
class AccountTile extends StatelessWidget {
  AccountTile(
      {super.key,
      required this.icon,
      required this.name,
      required this.voidCallback});
  final IconData icon;
  final String name;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 17),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
