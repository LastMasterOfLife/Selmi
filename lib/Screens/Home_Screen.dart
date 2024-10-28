import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/model/Richiesta_Model.dart';
import 'package:prove/widgets/customer_scaffold.dart';
import 'Document_main_screen.dart';
import 'Product_main_screen.dart';


/// IMPORTANTE
/// questo widget non viene utilizzato ma viene usato all'interno del custromer_scaffold.dart
class HomeScreen extends StatefulWidget {

  final String accesso;
  final String name;
  final String surname;
  final String username;
  final String emaiil;
  final String password;
  final String serialcode;

  const HomeScreen({required this.accesso, super.key, required this.name, required this.surname, required this.username, required this.emaiil, required this.password, required this.serialcode});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomScaffold(
        pages: [
          Column(
            children: <Widget>[
              _buildHeader(),
              _buildLastScannedMachinesSection(),
              _buildLastOpenedDocumentsSection(),
            ],
          ),
          Center(child: Text('Search Page')),
          Center(child: Text('Qr Page')),
          Center(child: Text('Saved Page')),
          Center(child: Text('Settings Page')),
        ],
        accesso: widget.accesso, name: widget.name, surname: widget.surname, username: widget.username, emaiil: widget.emaiil, password: widget.password, serialcode: widget.serialcode,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset('assets/images/selmi_logo.png', height: 200),
        SizedBox(height: 10),
        _buildSectionTitle("Last scanned machine"),
        SizedBox(height: 0),
      ],
    );
  }

  Widget _buildLastScannedMachinesSection() {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: fetchTemperaggioData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: error)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found', style: TextStyle(color: error)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return _buildMachineListItem(item);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildMachineListItem(dynamic item) {
    return ListTile(
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductMainScreen(
                nome: item['nome'], // Passa il nome
                immagine: item['Image'], // Passa l'immagine
              ),
            ),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(item['Image'], height: 80, width: 50, fit: BoxFit.cover),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['nome'], style: TextStyle(fontSize: 18, color: secondary)),
                Row(
                  children: [
                    Text(item['category'], style: TextStyle(color: secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(width: 20),
                    Text(item['year'], style: TextStyle(color: secondary)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLastOpenedDocumentsSection() {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildSectionTitle("Last documents opened"),
        SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: fetchDocumentiData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: error)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found', style: TextStyle(color: error)));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];
                    return _buildDocumentListItem(item);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentListItem(dynamic item) {
    return ListTile(
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DocumentMainScreen()),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/pdf_icon.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: TextStyle(fontSize: 18, color: secondary)),
                Row(
                  children: [
                    Text(item['data'], style: TextStyle(color: secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(width: 20),
                    Text(item['tipo'], style: TextStyle(color: secondary)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2)),
      ),
      child: Text(title, style: TextStyle(color: primary, fontSize: 25)),
    );
  }
}
