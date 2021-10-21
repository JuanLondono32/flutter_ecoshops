import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';
class OrderCard extends StatelessWidget {
  final Map info;
  //final void Function() press;
  const OrderCard({
    Key? key,
    required this.info,
    //required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
							return Padding(
								padding: const EdgeInsets.all(8),	
								child: Card(
									child: Padding(padding: const EdgeInsets.all(8), child:
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [	
												Text('Orden #'+info['id_orden'].toString(),
											 	style: TextStyle(fontSize:20),),
												SizedBox(height: 8,),
												Text('Fecha: ',),
                        Divider(thickness: 2,),
                        Column(children:List<Padding>.generate(info['productos'].length, (index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(info['productos'][index]),
                                  ]
                                )
                              ]
                            )
                          );
                            
                          }),
                        ),


                        Divider(thickness: 2,),
                        Row(children: [
                          Icon(Icons.location_on_outlined,color: Color(0xFF597C2B),),
                          SizedBox(width: 10,),
                          Text(info['direccion'],style: TextStyle(fontSize: 11),)
                        ],),
                        Divider(thickness: 2,),
                        IntrinsicHeight(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Total', style: TextStyle(color:Colors.grey),),
                                SizedBox(height: 8,),
                                Text('\$'+info['total'].toString().padLeft(6,'0'), style: TextStyle(color:Colors.black),),
                              ],
                            ),
                            VerticalDivider(thickness: 1,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Estado', style: TextStyle(color:Colors.grey),),
                                SizedBox(height: 8,),
                                Text('${info['estado'].padLeft(6,'0')}', style: TextStyle(color:Colors.black),),
                              ],
                            ),
                          ],),
                        )
											],
										),),
								),
							);
						}
}