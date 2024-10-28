import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Document_main_screen.dart';
import 'package:prove/model/Object_class.dart';
import 'package:provider/provider.dart';

import 'Qr_scan_main_screen.dart';

class ProductMainScreen extends StatefulWidget {
  final String nome;
  final String immagine;

  const ProductMainScreen({required this.nome, required this.immagine, super.key});

  @override
  State<ProductMainScreen> createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen> {
  bool isStar = false;

  void navigateToDocumentScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => DocumentMainScreen()));
  }

  @override
  void initState() {
    super.initState();
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    isStar = itemProvider.itemList.any((item) => item.titolo == widget.nome);
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProductImage(itemProvider),
          _buildSections(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: neutral),
      title: Text(widget.nome, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: neutral)),
      backgroundColor: primary,
    );
  }

  Widget _buildProductImage(ItemProvider itemProvider) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Center(child: Image.network(widget.immagine, height: 300)),
          _buildFavoriteIcon(itemProvider),
          _buildQrIcon(),
          _buildLanguageIcon(),
        ],
      ),
    );
  }

  Positioned _buildFavoriteIcon(ItemProvider itemProvider) {
    return Positioned(
      top: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          setState(() {
            isStar = !isStar;
            isStar ? itemProvider.toggleItem(widget.nome, widget.immagine) : itemProvider.removeItem(widget.nome);
          });
        },
        child: Icon(isStar ? Icons.star : Icons.star_border),
      ),
    );
  }

  Positioned _buildQrIcon() {
    return Positioned(
      bottom: 20,
      left: 20,
      child: InkWell(
        onTap: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrScanMainScreen()),
            );
          });
        },
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Positioned _buildLanguageIcon() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          // Implement language selection action here
        },
        child: Image.asset("assets/images/language_icon.png"),
      ),
    );
  }

  Widget _buildSections() {
    return Column(
      children: [
        SizedBox(height: 50),
        _buildSection("Specs", navigateToDocumentScreen, ),
        SizedBox(height: 30),
        _buildSection("Manual" ,navigateToDocumentScreen),
        SizedBox(height: 30),
        _buildSection("Other",navigateToDocumentScreen),
      ],
    );
  }

  Widget _buildSection(String title, VoidCallback onTap) {
    String documentName;

    // Imposta il nome del documento in base al tipo
    if (title == 'Specs') {
      documentName = "Specifiche";
    } else if (title == 'Manual') {
      documentName = "Manuale";
    } else {
      documentName = "Documento"; // Impostazione predefinita
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset("assets/images/pdf_icon.png"),
          SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 25, color: primary)),
                  Row(
                    children: [
                      Text(documentName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: secondary)),
                      Spacer(),
                      Text("16/10/2024", style: TextStyle(color: secondary)),
                      Spacer(),
                      Text("pdf", style: TextStyle(color: secondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
