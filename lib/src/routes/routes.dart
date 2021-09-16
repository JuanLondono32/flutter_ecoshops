import 'package:flutter/material.dart';

import 'package:flutter_ecoshops/src/pages/screens.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'products': (BuildContext context) => ProductScreen(),
    'product_form': (BuildContext context) => ProductForm(),
    'login': (BuildContext context) => LoginScreen(),
    'forgot_password': (BuildContext context) => ForgotPassword(),
    'create_account': (BuildContext context) => CreateAccount(),
  };
}
