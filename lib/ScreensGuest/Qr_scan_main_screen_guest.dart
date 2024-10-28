import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:prove/ScreensGuest/Scan_product_screen_guest.dart';

import '../Screens/Product_main_screen.dart';

class QrScanMainScreenGuest extends StatefulWidget {

  const QrScanMainScreenGuest({super.key});

  @override
  State<QrScanMainScreenGuest> createState() => _QrScanMainScreenGuestState();
}

class _QrScanMainScreenGuestState extends State<QrScanMainScreenGuest> {

  String scannedResult = "Nessun risultato";

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        // Passa il nome e l'immagine al nuovo widget
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanProductScreenGuest(
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
