import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:provider/provider.dart';

import '../model/Object_class.dart';
import 'Qr_scan_main_screen.dart';

class SavedMainScreen extends StatefulWidget {
  @override
  _SavedMainScreen createState() => _SavedMainScreen();
}

class _SavedMainScreen extends State<SavedMainScreen> {
  // Variabile per tracciare il tab selezionato
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only( left: 20, right: 20, top: 50, bottom: 20),
          decoration: BoxDecoration(
            color: primary,
          ),
          child: SearchBar(
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
        ), // Search bar
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Tab "Owned"
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0; // Imposta "Owned" come selezionato
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: selectedIndex == 0 ? secondary : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0), // Arrotonda solo l'angolo in alto a destra
                  ),
                  border: Border.all(
                    color: primary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "Owned",
                      style: TextStyle(
                        color: selectedIndex == 0 ? neutral : primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Tab "Favourites"
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1; // Imposta "Favourites" come selezionato
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: selectedIndex == 1 ? secondary : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), // Arrotonda solo l'angolo in alto a sinistra
                  ),
                  border: Border.all(
                    color: primary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "Favourites",
                      style: TextStyle(
                        color: selectedIndex == 1 ? neutral : primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ), // fa la stessa cosa di InkWell
          ],
        ),
        // Contenuto dinamico basato sul tab selezionato
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: neutral,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                if (itemProvider.itemList.isEmpty) {
                  return Center(
                    child: Text(
                      selectedIndex == 0 ? "Owned content" : "Favourites content",
                      style: TextStyle(color: primary, fontSize: 20),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: itemProvider.itemList.length,
                    itemBuilder: (context, index) {
                      final item = itemProvider.itemList[index];
                      return ListTile(
                        leading: Image.network(item.immagine),
                        title: Text(item.titolo, style: TextStyle(color: primary)),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(item.categoria, style: TextStyle(color: primary)),
                            SizedBox(width: 20,),
                            Text(item.data, style: TextStyle(color: primary)),
                          ],
                        ),
                        onTap: (){
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            itemProvider.removeItem(item
                                .titolo); // Rimuove l'elemento al clic dopo il ciclo di build
                          });
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
