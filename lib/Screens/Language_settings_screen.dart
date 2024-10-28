import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {

  bool chinese = false;
  bool english = false;
  bool french = false;
  bool german = false;
  bool italian = false;
  bool spanish = false;
  bool russian = false;
  bool turkish = false;

  int? selectedCheckboxIndex = 1; // Variabile per l'indice del checkbox selezionato
  final List<String> options = [
    'Chinese',
    'English',
    'French',
    'German',
    'Italian',
    'Spanish',
    'Russian',
    'Turkish'
  ]; // Lista di descrizioni per ciascun checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: variant),
        backgroundColor: primary,
        title: Text("LANGUAGE", style: TextStyle(color: variant),),
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Text("Select Your Language", style: TextStyle(fontSize: 25, color: primary),),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: options.length, // Numero di checkbox basato sulla lunghezza della lista
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(options[index]), // Testo diverso per ciascun checkbox
                  value: selectedCheckboxIndex == index,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCheckboxIndex = index; // Seleziona il checkbox corrente
                      } else {
                        selectedCheckboxIndex = null; // Deseleziona tutti
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
