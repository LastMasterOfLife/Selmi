import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import '../Texts/Text.dart';

class AccessibilitySettingsScreen extends StatefulWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  State<AccessibilitySettingsScreen> createState() => _AccessibilitySettingsScreenState();
}

class _AccessibilitySettingsScreenState extends State<AccessibilitySettingsScreen> {
  bool isTextToSpeechOn = true;  // Variabile per il Text to Speech
  bool isColorBlindnessModeOn = false;  // Variabile per il Color Blindness Mode
  int? selectedCheckboxIndex = 0; // Imposta la prima checkbox come selezionata di default

  final List<String> options = [
    'Protanopia (Red-Green)',
    'Deuteranopia (Red-Green)',
    'Tritanopia (Blue-Yellow)',
    'Achromatopia (Grayscale)',
  ]; // Lista di descrizioni per ciascun checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: neutral,
        ),
        backgroundColor: primary,
        title: const Text('ACCESSIBILITY', style: TextStyle(color: neutral)),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Text to Speech",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(child: Text(DescriptionTexttoSpeach)),
                Switch(
                  value: isTextToSpeechOn,
                  onChanged: (newValue) => setState(() => isTextToSpeechOn = newValue),
                  activeColor: primary,
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Color Blindness Mode",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(child: Text(DescriptionBlindness)),
                Switch(
                  value: isColorBlindnessModeOn,
                  onChanged: (newValue) => setState(() => isColorBlindnessModeOn = newValue),
                  activeColor: primary,
                ),
              ],
            ),
          ),

          Expanded(  // Aggiungi Expanded per evitare overflow
            child: ListView.builder(
              itemCount: options.length, // Numero di checkbox basato sulla lunghezza della lista
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(options[index]), // Testo diverso per ciascun checkbox
                  value: selectedCheckboxIndex == index,
                  onChanged: isColorBlindnessModeOn  // Controllo se lo switch è attivo
                      ? (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCheckboxIndex = index; // Seleziona il checkbox corrente
                      } else {
                        selectedCheckboxIndex = null; // Deseleziona tutti
                      }
                    });
                  }
                      : null, // Se disattivato, onChanged è nullo, quindi i checkbox non sono cliccabili
                  controlAffinity: ListTileControlAffinity.leading, // Allinea il checkbox a sinistra
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

