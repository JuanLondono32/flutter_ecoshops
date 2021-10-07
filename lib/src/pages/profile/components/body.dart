import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Registrar Emprendimiento",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(context, 'register_entrepreneurship');
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              var authServices =
                  Provider.of<AuthService>(context, listen: false);
              authServices.signOut();
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
