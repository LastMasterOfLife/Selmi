import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:provider/provider.dart';

import '../model/Object_class.dart';


class DocumentMainScreens extends StatelessWidget {
  final String nome;
  DocumentMainScreens({required this.nome, super.key});


  @override
  Widget build(BuildContext context) {
    return DocumentMainScreen();
  }
}


class DocumentMainScreen extends StatefulWidget {
  const DocumentMainScreen({super.key});

  @override
  State<DocumentMainScreen> createState() => _DocumentMainScreenState();
}

class _DocumentMainScreenState extends State<DocumentMainScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: neutral),
        backgroundColor: primary,
        title: const Text("Documento", style: TextStyle(fontSize: 30, color: neutral),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Image.asset("assets/images/pdf_Temperatrici.jpg")),
                    ),
                    Positioned( bottom:20, right: 20, child: InkWell(onTap: (){}, child: Image.asset("assets/images/language_icon.png"))),
                    Positioned(bottom: 20, left: 20, child: InkWell(onTap: (){}, child: const Icon(Icons.remove_red_eye_outlined))),

                  ],
                ),
              ),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Text("Description", style: TextStyle(fontSize: 25),)
                  ],
                )
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text("La temperatrice modello CENTO si allinea alle versioni TOP EX e FUTURA EX conservandone le caratteristiche innovative delle stesse ma potenziando notevolmente la quantità produttiva grazie alla vasca da 100 kg che consentirà la ricopertura in tunnel di larghezza fino a 600 mm."), // description
                    SizedBox(height: 100,),
                    const Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("20/04/2010" , style: TextStyle(fontSize: 20),),
                        SizedBox(width: 150,),
                        Text("pdf", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 2, style: BorderStyle
                                    .solid, color: primary),
                                borderRadius: BorderRadius.circular(50)
                            )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 30,right: 30, top: 10, bottom: 10),
                          child: Text("Download", style: TextStyle( color: neutral, fontSize: 35, fontWeight: FontWeight.bold),),
                        )),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondary,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2, style: BorderStyle
                                        .solid, color: secondary),
                                    borderRadius: BorderRadius.circular(50)
                                )
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.error, color: neutral,),
                                Text("Report error", style: TextStyle(color: neutral, fontSize: 15),),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
