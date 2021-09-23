import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/user.dart';
import 'package:flutter_ecoshops/palette.dart';
import 'package:flutter_ecoshops/services/users_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ecoshops/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userServices = Provider.of<UsersService>(context);
    final User user =
        new User(mail: "", password: "", birthDate: DateTime.now());
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'EcoShops',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    onChanged: (value) {
                      user.mail = value;
                    },
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Contraseña',
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    onChanged: (value) {
                      user.password = value;
                    },
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, 'forgot_password'),
                    child: Text(
                      'Olvidé mi contraseña',
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    buttonName: 'Iniciar Sesión',
                    onPressed: () async {
                      bool x = await userServices.verifyUser(user);
                      print(x);
                      Navigator.pushNamed(context, 'create_account');
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'create_account'),
                child: Container(
                  child: Text(
                    'Crear cuenta nueva',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
