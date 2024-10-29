import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';

class AddProducts extends StatefulWidget {

  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool _isCheck = false;
  bool _isCheckManual = false;
  bool _isCheckOther = false; // Controlla se il ceck_box è ceccato o meno

  final _titleInput = TextEditingController();

  void _selezione(){
    setState(() {
      _isCheck = !_isCheck;
    });
  }
  void _selezioneManual(){
    setState(() {
      _isCheckManual = !_isCheckManual;
    });
  }
  void _selezioneOther(){
    setState(() {
      _isCheckOther = !_isCheckOther;
    });
  }

  void _back(){
    setState(() {
      Navigator.pop(context);
    });
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      child: SizedBox(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: primary, fontSize: 18),
          decoration: InputDecoration(
            filled: true,
            fillColor: neutral,
            border: const OutlineInputBorder(),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
            hintStyle: const TextStyle(color: primary),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }

  Future buildShowDialog(context, String titolo, String testo){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titolo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Added", style: TextStyle(color: primary),),
              Text(testo, style: TextStyle(color: primary),),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il popup
              },
              child: Text('Chiudi', style: TextStyle(color: primary),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              decoration: BoxDecoration(
                color: primary
              ),
                child: buildTextField(_titleInput, 'Name Product')),
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Center(
                        child: Container(
                            height: 300,
                            child: Icon(Icons.add_a_photo_outlined,size: 100,))),
                  ),
                  Positioned(
                      top: 20, right: 20,
                      child: Icon(Icons.star_border)),
                  Positioned(
                      bottom: 20, left: 20,
                      child: Icon(Icons.qr_code_scanner)),
                  Positioned(
                      bottom: 20, right: 20,
                      child: Image.asset("assets/images/language_icon.png")),
                ],
              ),
            ), // immagine
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Specs", style: TextStyle(fontSize: 25, color: primary)),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.add),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // specs
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manual", style: TextStyle(fontSize: 25, color: primary)),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: IconButton(
                                    onPressed: (){},
                                     icon: Icon(Icons.add),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // manual
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Other", style: TextStyle(fontSize: 25, color: primary)),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.add),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 120,right: 120),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(width: 2, color: primary))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_left),
                                )),
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: (){
                                buildShowDialog(context, 'Add Product', _titleInput.text);
                                _titleInput.text = ' ';
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )// other
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
