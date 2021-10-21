import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/src/pages/oferta_materia_card.dart';



class OfertaMateriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyOferta(),
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

class BodyOferta extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyOferta> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
final ofertas_prueba=[
{'direccion':"Cra 12", 'descripcion':"Botellas de vidrio", 'email':"donante@mail.com"},
{'direccion':"Cra 12", 'descripcion':"Botellas de vidrio", 'email':"donante@mail.com"},
{'direccion':"Cra 12", 'descripcion':"Botellas de vidrio", 'email':"donante@mail.com"},
{'direccion':"Cra 12", 'descripcion':"Botellas de vidrio", 'email':"donante@mail.com"},
];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text("Oferta de Materia Prima", style: Theme.of(context).textTheme.headline5
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
              itemCount: ofertas_prueba.length,
              itemBuilder: (context, index) => OfertaMateriaCard(info:ofertas_prueba[index]),
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

