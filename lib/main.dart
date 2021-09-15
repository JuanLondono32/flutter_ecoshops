import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:flutter_ecoshops/src/routes/routes.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ecoshops/services/products_service.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => CategoriesService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecoshops",
      debugShowCheckedModeBanner: false,

      //Routing
      initialRoute: "products",
      routes: getApplicationRoutes(),
    );
  }
}
