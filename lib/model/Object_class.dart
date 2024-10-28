import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prove/Colors/color_palette.dart';

class Oggetto {
  String titolo = '';
  String categoria = '';
  String data = '';
  String immagine = '';

  Oggetto({required this.titolo, required this.categoria, required this.data, required this.immagine});

}

class ItemProvider with ChangeNotifier {
  List<Oggetto> _itemList = [];

  List<Oggetto> get itemList => _itemList;

  void toggleItem(String title, String img) {
    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    // Se l'elemento esiste già, lo rimuoviamo; altrimenti, lo aggiungiamo
    if (_itemList.any((oggetto) => oggetto.titolo == title) && _itemList.any((oggetto)=> oggetto.immagine == img)) {
      _itemList.removeWhere((oggetto) => oggetto.titolo == title);
      _itemList.removeWhere((oggetto)=> oggetto.immagine == img);
    } else {
      _itemList.add(Oggetto(
        titolo: title,
        categoria: "Temperaggio",
        data: currentDate,
        immagine: img, // Modifica con l'URL o percorso dell'immagine
      ));
    }
    notifyListeners(); // Notifica il cambiamento
  }

  // Metodo per svuotare la lista
  void clearAll() {
    _itemList.clear(); // Rimuove tutti gli elementi dalla lista
    notifyListeners(); // Notifica il cambiamento ai listener
  }

  // Metodo per rimuovere un singolo item dalla lista
  void removeItem(String titolo) {
    _itemList.removeWhere((oggetto) => oggetto.titolo == titolo);
    notifyListeners(); // Notifica il cambiamento ai listener
  }
}