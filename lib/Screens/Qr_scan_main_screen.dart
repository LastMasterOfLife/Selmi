import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Product_main_screen.dart';

class QrScanMainScreen extends StatefulWidget {
  const QrScanMainScreen({super.key});

  @override
  _QrScanMainScreen createState() => _QrScanMainScreen();
}

class _QrScanMainScreen extends State<QrScanMainScreen> {

  final TextEditingController _search = TextEditingController();
  String scannedResult = "Nessun risultato";

  final List<String> AllOptions = [
    'TEMPERAGGIO(categoria)', 'RICOPERTURA PRODOTTI CON IL CIOCCOLATO(categoria)', 'MODELLAGGIO CIOCCOLATO(categoria)',
    'CHOCAPAINT(categoria)', 'TUNNEL di RAFFREDDAMENTO e RICOPERTURA(categoria)', 'ONE SHOT TUTTUNO(categoria)',
    'CLUSTER(categoria)', 'CONFETTATRICI BASSINE(categoria)', 'SCIOGLITORI e MISCELATORI(categoria)', 'ESTRUSORI(categoria)',
    'RAFFINATRICI A SFERE(categoria)', 'TOSTATRICI(categoria)', 'BEAN TO BAR(categoria)', 'LAVORAZIONE FRUTTA SECCA(categoria)',
    'FONTANE DI CIOCCOLATO(categoria)', 'Selmi One Temperatrice Cioccolato(macchine)','Legend Temperatrice Cioccolato(macchine)',
    'Color ex Temperatrice Cioccolato(macchine)', 'Plus Ex Temperatrice Cioccolato(macchine)', 'Futura Ex Temperatrice Cioccolato(macchine)',
    'Top Ex Temperatrice Cioccolato(macchine)', 'Cento Temperatrice Cioccolato(macchine)', 'R200 Legend(macchine)', 'RS200(macchine)', 'Truffle(macchine)',
    'Automatic Truffle(macchine)', 'R400t Plus(macchine)', 'R600t(macchine)', 'Mould Loader 175(macchine)', 'Moulding Line 275(macchine)',
    'Smodellatore Automatico(macchine)', 'Injection Plate(macchine)', 'Filler Praline(macchine)', 'Filler Vasi(macchine)', 'Galileo(macchine)', 'Spider(macchine)',
    'Spider Max(macchine)', 'Smodellatore Automatico(macchine)', 'Tunnel 200/250mm(macchine)', 'Tunnel 300/400mm(macchine)', 'Tunnel 600mm(macchine)', 'Drops System(macchine)',
    'One Shot Tuttuno 4(macchine)', 'One Shot Tuttuno 9(macchine)', 'Charger 175/275(macchine)', 'Vibra(macchine)','Depositor(macchine)', 'Spinner Exit 175/275(macchine)',
    'Cluster(macchine)', 'Cluster Teglia(macchine)', 'Comfit(macchine)', 'Comfit Maxi(macchine)', 'Spaysystem(macchine)', 'Tank 200(macchine)', 'Tank 400(macchine)', 'Chocoform(macchine)',
    'Chiocoliner(macchine)', 'Extrudeer(macchine)', 'Micron 25(macchine)', 'Micron 50(macchine)', 'Tostatrice Roaster 106(macchine)', 'Tostatrice Roaster 120(macchine)',
    'Winnower(macchine)', 'Grinder Plus(macchine)', 'Conca 100(macchine)', 'Conca 200-400(macchine)', 'Vaglio(macchine)', 'Grinder Plus(macchine)', 'Grain(macchine)', 'Vaglio(macchine)',
    'Macchia(macchine)', 'Macchia Temperante(macchine)', 'Fontana a muro(macchine)'
  ];

  late List<String> filteredOptions;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredOptions = AllOptions; // Inizializza con tutte le opzioni

    _search.addListener(() {
      setState(() {
        isSearching = _search.text.isNotEmpty;
        filteredOptions = AllOptions.where((option) => option.toLowerCase().contains(_search.text.toLowerCase())).toList();
      });
    });
  }

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        // Passa il nome e l'immagine al nuovo widget
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductMainScreen(
              nome: result.rawContent,
              immagine: "https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato.png",
            ),
          ),
        );
      } else {
        setState(() => scannedResult = "Nessun contenuto rilevato");
      }
    } catch (e) {
      setState(() => scannedResult = "Errore nella scansione: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/crop_free.png"),
              SizedBox(height: 80,),
              ElevatedButton(
                onPressed: scanBarcode,
                child: const Text('Scansiona QR Code'),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              _buildManualCodeEntry(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManualCodeEntry() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: primary),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: TextField(
        controller: _search,
        decoration: InputDecoration(
          hintText: "Insert code",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 20),
          suffixIcon: IconButton(
            icon: Icon(Icons.backspace_outlined, color: primary),
            onPressed: () => setState(() {
              scannedResult = "";
              scanBarcode();
            }),
          ),
        ),
      ),
    );
  }
}
