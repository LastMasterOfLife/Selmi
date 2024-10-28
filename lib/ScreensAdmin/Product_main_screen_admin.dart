import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Home_Screen.dart';
import 'package:prove/ScreensAdmin/Product_edit_screen_admin.dart';
import 'package:provider/provider.dart';
import '../Screens/Document_main_screen.dart';
import '../model/Object_class.dart';

class ProductMainScreenAdmin extends StatefulWidget {
  final String nome;
  final String immagine;

  final String name;
  final String surname;
  final String username;
  final String emaiil;
  final String password;
  final String serialcode;


  const ProductMainScreenAdmin({
    super.key,
    required this.nome,
    required this.immagine, required this.name, required this.surname, required this.username, required this.emaiil, required this.password, required this.serialcode,
  });

  @override
  State<ProductMainScreenAdmin> createState() => _ProductMainScreenAdminState();
}

class _ProductMainScreenAdminState extends State<ProductMainScreenAdmin> {
  bool isStar = false;
  late ItemProvider itemProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    itemProvider = Provider.of<ItemProvider>(context, listen: false);
    isStar = itemProvider.itemList.any((item) => item.titolo == widget.nome);
  }

  void navigateToDocumentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DocumentMainScreen()),
    );
  }

  void _edit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEditScreenAdmin(
          nome: widget.nome,
          immagine: widget.immagine,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: neutral),
        title: Text(
          widget.nome,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: neutral),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  HomeScreen(accesso: 'admin', name: widget.name, surname: widget.surname, username: widget.username, emaiil: widget.emaiil, password: widget.password, serialcode: widget.serialcode,)),
                  (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageSection(),
            const SizedBox(height: 50),
            _buildDocumentSection("Specs", "Specifiche", "16/10/2024", "pdf"),
            const SizedBox(height: 50),
            _buildDocumentSection("Manual", "Manuale", "16/10/2024", "pdf"),
            const SizedBox(height: 50),
            _buildDocumentSection("Other", "Documento", "16/10/2024", "pdf"),
            const SizedBox(height: 30),
            _buildEditButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Center(child: Image.network(widget.immagine, height: 300)),
          Positioned(
            top: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                setState(() {
                  isStar = !isStar;
                  if (isStar) {
                    itemProvider.toggleItem(widget.nome, widget.immagine);
                  } else {
                    itemProvider.removeItem(widget.nome);
                  }
                });
              },
              child: Icon(isStar ? Icons.star : Icons.star_border),
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 20,
            child: Icon(Icons.qr_code_scanner),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Image.asset("assets/images/language_icon.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection(String title, String documentName, String uploadDate, String fileType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset("assets/images/pdf_icon.png"),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: navigateToDocumentScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 25, color: primary)),
                  Row(
                    children: [
                      Text(documentName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: secondary)),
                      const Spacer(),
                      Text(uploadDate, style: TextStyle(color: secondary)),
                      const Spacer(),
                      Text(fileType, style: TextStyle(color: secondary)),
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

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 140),
      child: InkWell(
        onTap: _edit,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 2, color: primary),
            ),
          ),
          child: const Icon(Icons.mode_edit),
        ),
      ),
    );
  }
}
