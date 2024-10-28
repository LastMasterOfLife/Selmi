import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Qr_scan_main_screen.dart';
import 'package:prove/Screens/List_machine_search_screen.dart';
import 'package:prove/ScreensAdmin/Search_edit_screen_admin.dart';

class SearchMainScreenAdmin extends StatefulWidget {
  const SearchMainScreenAdmin({super.key});

  @override
  State<SearchMainScreenAdmin> createState() => _SearchMainScreenAdminState();
}

class _SearchMainScreenAdminState extends State<SearchMainScreenAdmin> {

  final TextEditingController _search = TextEditingController();

  int? selectedTextIndex; // Variabile per l'indice del checkbox selezionato
  final List<String> options = [
    'TEMPERAGGIO',
    'RICOPERTURA PRODOTTI CON IL CIOCCOLATO',
    'MODELLAGGIO CIOCCOLATO',
    'CHOCAPAINT',
    'TUNNEL di RAFFREDDAMENTO e RICOPERTURA',
    'ONE SHOT TUTTUNO',
    'CLUSTER',
    'CONFETTATRICI BASSINE',
    'SCIOGLITORI e MISCELATORI',
    'ESTRUSORI',
    'RAFFINATRICI A SFERE',
    'TOSTATRICI',
    'BEAN TO BAR',
    'LAVORAZIONE FRUTTA SECCA',
    'FONTANE DI CIOCCOLATO'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0, bottom: 1.0), // Riduce lo spazio sui lati
            child: Column(
              children: [
                SizedBox(height: 50),
                 SearchBar(
                  hintText: "Search...",
                  trailing: <Widget>[
                    IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: primary)),
                    IconButton(onPressed: (){
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QrScanMainScreen()),
                        );
                      });
                    }, icon: const Icon(Icons.qr_code_scanner,color: primary)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length, // Numero di checkbox basato sulla lunghezza della lista
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedTextIndex = index;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ListMachineSearchScreen(category: options[index])),
                            );
                          });
                        },
                        child: Container(
                          color: selectedTextIndex == index ? primary : Colors.transparent, // Cambia colore di sfondo
                          child: ListTile(
                            title: Text(options[index], style: TextStyle(
                              color: selectedTextIndex == index ? variant : primary,
                              fontWeight: selectedTextIndex == index ? FontWeight.bold : FontWeight.normal, // Cambia spessore se selezionato
                            ),), // Testo diverso per ciascun checkbox

                          ),
                        ),
                      );
                    },
                  ),
                ), // lista categorie
              ],
            ),
          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(left: 140, right: 140, bottom: 16),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchEditScreenAdmin(name: '', surname: '', username: '', emaiil: '', password: '', serialcode: '',)));
                  },
                    child: Icon(Icons.edit, color: neutral,)),
              ))
        ],
      )

    );
  }
}
