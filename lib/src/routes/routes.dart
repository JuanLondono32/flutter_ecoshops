import 'package:flutter/material.dart';

import 'package:flutter_ecoshops/src/pages/home_page.dart';
import 'package:flutter_ecoshops/src/pages/products_form.dart';
import 'package:flutter_ecoshops/src/pages/products_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'products': (BuildContext context) => ProductScreen(),
    'product_form': (BuildContext context) => ProductForm(),
  };
}
