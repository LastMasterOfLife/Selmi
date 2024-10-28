import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Qr_scan_main_screen.dart';
import 'package:prove/Screens/List_machine_search_screen.dart';
import 'package:prove/Screens/Search_input_screen.dart';
import 'package:prove/Texts/Text.dart';


class SearchMainScreen extends StatefulWidget {
  @override
  _SearchMainScreen createState() => _SearchMainScreen();
}

class _SearchMainScreen extends State<SearchMainScreen> {

  final TextEditingController _search = TextEditingController();
  bool isSearching = false; // Variabile per sapere se si sta cercando


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
    'FONTANE DI CIOCCOLATO',
  ]; // Lista di descrizioni per ciascun checkbox

  bool isFlipped = false;

  bool isAscending = true; // Stato per sapere se la lista è ordinata in modo crescente o decrescente


  @override
  void initState() {
    super.initState();
    // Aggiungi un listener al TextEditingController per monitorare il testo
    _search.addListener(() {
      setState(() {
        isSearching = _search.text.isNotEmpty;
      });
    });
  }

  void _flipIcon() {
    setState(() {
      isFlipped = !isFlipped; // Cambia lo stato del flip
    });
  }

  void order (){
    setState(() {
      if (isAscending) {
        options.sort((a, b) => a.compareTo(b)); // Ordina in ordine alfabetico
      } else {
        options.sort((a, b) => b.compareTo(a)); // Ordina in ordine alfabetico inverso
      }
      isAscending = !isAscending; // Alterna tra crescente e decrescente
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only( left: 20, right: 20, top: 50, bottom: 20),
              decoration: BoxDecoration(
                color: primary,
              ),
              child: SearchBar(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchInputScreen(name: '', surname: '', username: '', emaiil: '', password: '', serialcode: '')));
                },
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0, bottom: 1.0), // Riduce lo spazio sui lati
              child: Column(
                children: [
                  const SizedBox(height: 90),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                            order();
                            _flipIcon();
                          },
                          child: Transform(
                              transform: Matrix4.identity()..scale(1.0,isFlipped ? -1.0 : 1.0), // Scala invertita sull'asse y
                              alignment: Alignment.center,
                              child: Icon(Icons.swap_vert, color: neutral,))),
                    ],
                  ),
                ))
          ],
        )
    );
  }
}
