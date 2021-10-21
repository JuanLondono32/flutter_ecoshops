import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/src/pages/order_card.dart';




class SalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodySales(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}

class BodySales extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodySales> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ordenes_prueba=[
{'id_orden':1,'productos':['Producto 1','Producto 2'],'direccion':'Cra 12','estado':'No pagado','total':30000},
{'id_orden':2,'productos':['Producto 1','Producto 2'],'direccion':'Cra 12','estado':'No pagado','total':30000},
{'id_orden':3,'productos':['Producto 1','Producto 2'],'direccion':'Cra 12','estado':'No pagado','total':30000},
{'id_orden':4,'productos':['Producto 1','Producto 2'],'direccion':'Cra 12','estado':'No pagado','total':30000},
];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text("Órdenes", style: Theme.of(context).textTheme.headline5
              // .copyWith(fontWeight: FontWeight.bold),
              ),
        ),
        Expanded(
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: ordenes_prueba.length,
              itemBuilder: (context, index) => OrderCard(info:ordenes_prueba[index]),
            ),
          ),
        ),
        )
        /*Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("product")
                  .where('category_prod', isEqualTo: categories[selectedIndex])
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('No products yet...');
                } else {
                  return GridView.builder(
                      itemCount: snapshot.data!.size,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        var ref = snapshot.data!.docs[index];
                        var newProduct =
                            new Product.fromMap((ref.data() as dynamic));
                        newProduct.id = ref.id;
                        return ItemCard(
                          product: newProduct,
                        );
                      });
                }
              },
            ),
          ),
        ),*/
      ],
    );
  }

}

