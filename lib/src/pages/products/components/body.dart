import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/src/pages/product_detail/details_screen.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Productos",
            style: Theme.of(context)
                .textTheme
                .headline5
               // .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: demoProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: demoProducts[index],
                      
                    )),
          ),
        ),
      ],
    );
  }
}
