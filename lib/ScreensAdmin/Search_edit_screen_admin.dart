import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Home_Screen.dart';
import 'package:prove/Screens/Qr_scan_main_screen.dart';
import 'package:prove/Screens/List_machine_search_screen.dart';

class SearchEditScreenAdmin extends StatefulWidget {

  final String name;
  final String surname;
  final String username;
  final String emaiil;
  final String password;
  final String serialcode;
  const SearchEditScreenAdmin({super.key, required this.name, required this.surname, required this.username, required this.emaiil, required this.password, required this.serialcode});

  @override
  State<SearchEditScreenAdmin> createState() => _SearchEditScreenAdminState();
}

class _SearchEditScreenAdminState extends State<SearchEditScreenAdmin> {
  final TextEditingController _search = TextEditingController();
  int? selectedTextIndex; // Indice della selezione corrente
  bool isAscending = true;
  bool isFlipped = false;
  bool showCheckboxes = false; // Variabile per gestire la visibilità delle checkbox
  List<String> filteredOptions = [];
  List<bool> checkboxStates = [];

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
  void initState() {
    super.initState();
    filteredOptions = options;
    checkboxStates = List.filled(options.length, false); // Stati per le checkbox
  }

  void _flipIcon() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  void order() {
    setState(() {
      if (isAscending) {
        filteredOptions.sort((a, b) => a.compareTo(b));
      } else {
        filteredOptions.sort((a, b) => b.compareTo(a));
      }
      isAscending = !isAscending;
    });
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredOptions = options;
      } else {
        filteredOptions = options
            .where((option) =>
            option.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _toggleCheckboxesVisibility() {
    setState(() {
      showCheckboxes = !showCheckboxes; // Cambia la visibilità delle checkbox
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: neutral,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  controller: _search,
                  onChanged: _filterOptions,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 15).copyWith(left: 20),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 5),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: primary)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QrScanMainScreen()),
                              );
                            },
                            icon: const Icon(Icons.qr_code_scanner,
                                color: primary)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredOptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTextIndex = index;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListMachineSearchScreen(
                                      category: filteredOptions[index]),
                                ),
                              );
                            });
                          },
                          child: Container(
                            color: selectedTextIndex == index
                                ? primary
                                : Colors.transparent,
                            child: ListTile(
                              title: Row(
                                children: [
                                  if (showCheckboxes) // Mostra le checkbox solo se `showCheckboxes` è true
                                    Checkbox(
                                      value: checkboxStates[index],
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          checkboxStates[index] = newValue ?? false;
                                        });
                                      },
                                    ),
                                  Expanded(
                                    child: Text(
                                      filteredOptions[index],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: selectedTextIndex == index
                                            ? variant
                                            : primary,
                                        fontWeight: selectedTextIndex == index
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 80, right: 80, bottom: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(accesso: 'admin',name: widget.name, surname: widget.surname, username: widget.username, emaiil: widget.emaiil, password: widget.password, serialcode: widget.serialcode)));
                        },
                        child: const Icon(Icons.arrow_back, color: neutral),
                      ),
                      InkWell(
                        onTap: _toggleCheckboxesVisibility,
                        child: const Icon(Icons.check_box_outline_blank,
                            color: neutral),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.add, color: neutral),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.sort, color: neutral),
                      ),
                      InkWell(
                        onTap: () {
                          order();
                          _flipIcon();
                        },
                        child: Transform(
                            transform: Matrix4.identity()
                              ..scale(1.0, isFlipped ? -1.0 : 1.0),
                            alignment: Alignment.center,
                            child: const Icon(Icons.swap_vert, color: neutral)),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
