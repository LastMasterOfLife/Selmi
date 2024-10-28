import 'package:flutter/material.dart';
import 'package:prove/Screens/Document_main_screen.dart';
import 'package:prove/Screens/Product_main_screen.dart';
import 'package:prove/Screens/Home_Screen.dart';
import 'package:prove/Screens/Qr_scan_main_screen.dart';
import 'package:prove/Screens/Saved_main_screen.dart';
import 'package:prove/Screens/Search_main_screen.dart';
import 'package:prove/ScreensAdmin/Product_main_screen_admin.dart';
import 'package:prove/ScreensAdmin/Search_main_screen_admin.dart';
import 'package:prove/model/Richiesta_Model.dart';
import 'package:prove/Screens/Settings_main_screen.dart';
import 'package:prove/Colors/color_palette.dart';

class CustomScaffold extends StatefulWidget {
  final List<Widget> pages;
  final String accesso;
  final String name;
  final String surname;
  final String username;
  final String emaiil;
  final String password;
  final String serialcode;

  const CustomScaffold(
      {required this.pages,
      Key? key,
      required this.accesso,
      required this.name,
      required this.surname,
      required this.username,
      required this.emaiil,
      required this.password,
      required this.serialcode})
      : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _currentIndex = 0;

  void _navigateToDocumentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DocumentMainScreen()),
    );
  }

  void _onTapBottomNav(int index) {
    setState(() => _currentIndex = index);
  }

  Widget control() {
    if (widget.accesso == 'admin') {
      return const SearchMainScreenAdmin();
    } else {
      return SearchMainScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomePage(),
      //SearchMainScreen(),
      control(),
      const QrScanMainScreen(),
      SavedMainScreen(),
      SettingsMainScreen(
        accesso: widget.accesso,
        name: widget.name,
        surname: widget.surname,
        username: widget.username,
        emaiil: widget.emaiil,
        password: widget.password,
        serialcode: widget.serialcode,
      ),
    ];

    return Scaffold(
      //appBar: AppBar(backgroundColor: primary),
      //extendBodyBehindAppBar: true,
      body: _pages[_currentIndex],
      backgroundColor: neutral,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: secondary,
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
              icon: Icon(Icons.qr_code_scanner), label: 'Qr Scan'),
          NavigationDestination(icon: Icon(Icons.save_rounded), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      children: [
         const SizedBox(
          height: 40,
        ),
        Image.asset('assets/images/selmi_logo.png', height: 38),
        const SizedBox(height: 10),
        _buildSectionTitle(context, "LAST SCANNED MACHINES"),
        Expanded(child: _buildMachineList()),
        const SizedBox(height: 10),
        _buildSectionTitle(context, "LAST VIEWED DOCUMENTS"),
        Expanded(child: _buildDocumentList()),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 2))),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget _buildMachineList() {
    return FutureBuilder<List<dynamic>>(
      future: fetchTemperaggioData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: error)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: const Text('No data found',
                  style: const TextStyle(color: error)));
        } else {
          return ListView.separated(
            physics: const ClampingScrollPhysics(),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 10,
              );
            }),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildMachineListItem(snapshot.data![index]);
            },
          );
        }
      },
    );
  }

  Widget _buildMachineListItem(dynamic item) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductMainScreenAdmin(
              nome: item['nome'],
              immagine: item['Image'],
              name: '',
              surname: '',
              username: '',
              emaiil: '',
              password: '',
              serialcode: '',
            ),
          ),
        );
      },
      title: Text(
        item['nome'],
        style: const TextStyle(
          fontSize: 18,
          color: secondary,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item['category'],
            style: const TextStyle(
              color: secondary,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            item['year'],
            style: const TextStyle(
              color: secondary,
            ),
          ),
        ],
      ),
      leading: Image.network(
        item['Image'],
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDocumentList() {
    return FutureBuilder<List<dynamic>>(
      future: fetchDocumentiData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: error)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: const Text('No data found',
                  style: const TextStyle(color: error)));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildDocumentListItem(snapshot.data![index]);
            },
          );
        }
      },
    );
  }

  Widget _buildDocumentListItem(dynamic item) {
    return ListTile(
      title: InkWell(
        onTap: _navigateToDocumentScreen,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/pdf_icon.png'),
            ),
            Expanded(
              // Utilizza Expanded per allineare a sinistra
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'],
                      style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['data'],
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(width: 20),
                      Text(item['tipo'],
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
