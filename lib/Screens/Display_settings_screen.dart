import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Texts/Text.dart';

class DisplaySettingsScreen extends StatefulWidget {
  final String accesso;
  const DisplaySettingsScreen({Key? key, required this.accesso}) : super(key: key);

  @override
  State<DisplaySettingsScreen> createState() => _DisplaySettingsScreenState();
}

class _DisplaySettingsScreenState extends State<DisplaySettingsScreen> {
  bool isSwitchOn = true;
  double sliderValue = 0.5; // Valore iniziale dello slider (SeekBar)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Colore di sfondo
      appBar: AppBar(
        backgroundColor: primary,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("DISPLAY", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Theme Color",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(child: Text(DescriptionDisplay)),
                Switch(
                  value: isSwitchOn,
                  onChanged: (newValue) => setState(() => isSwitchOn = newValue),
                  activeColor: primary,
                ),
              ],
            ),
          ),

          // Barra di scorrimento (SeekBar)
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Text Size', style: TextStyle(color: primary, fontSize: 25)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // Testo sopra la barra
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Piccolo', style: TextStyle(color: primary)),
                    Text('Medio', style: TextStyle(color: primary)),
                    Text('Grande', style: TextStyle(color: primary)),
                  ],
                ),

                // Slider che sostituisce la barra
                Slider(
                  value: sliderValue,
                  min: 0.0,
                  max: 1.0,
                  divisions: 2, // Divide la barra in 3 parti (Piccolo, Medio, Grande)
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue;
                    });
                  },
                  activeColor: primary, // Colore della barra attiva
                  inactiveColor: secondary, // Colore della barra inattiva
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
