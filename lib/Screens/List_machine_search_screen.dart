import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Product_main_screen.dart';

class ListMachineSearchScreen extends StatefulWidget {
  final String category; // Nome della categoria passata dalla pagina di ricerca
  const ListMachineSearchScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ListMachineSearchScreen> createState() => _ListMachineSearchScreenState();
}

class _ListMachineSearchScreenState extends State<ListMachineSearchScreen> {
  int? selectedMachineIndex;

  final Map<String, List<String>> categoryItems = {
    'TEMPERAGGIO': [
      'Selmi One Temperatrice Cioccolato',
      'Legend Temperatrice Cioccolato',
      'Color ex Temperatrice Cioccolato',
      'Plus Ex Temperatrice Cioccolato',
      'Futura Ex Temperatrice Cioccolato',
      'Top Ex Temperatrice Cioccolato',
      'Cento Temperatrice Cioccolato',
    ],
    'RICOPERTURA PRODOTTI CON IL CIOCCOLATO': [
      'R200 Legend',
      'RS200',
      'Truffle',
      'Automatic Truffle',
      'R400t Plus',
      'R600t',
    ],
    'MODELLAGGIO CIOCCOLATO': [
      'Mould Loader 175',
      'Moulding Line 275',
      'Smodellatore Automatico',
      'Injection Plate',
      'Filler Praline',
      'Filler Vasi',
      'Galileo',
    ],
    'TUNNEL di RAFFREDDAMENTO e RICOPERTURA': [
      'Spider',
      'Spider Max',
      'Smodellatore Automatico',
      'Tunnel 200/250mm',
      'Tunnel 300/400mm',
      'Tunnel 600mm',
      'Drops System',
    ],
    'ONE SHOT TUTTUNO': [
      'One Shot Tuttuno 4',
      'One Shot Tuttuno 9',
      'Charger 175/275',
      'Vibra',
      'Depositor',
      'Spinner Exit 175/275',
    ],
    'CLUSTER': [
      'Cluster',
      'Cluster Teglia',
    ],
    'CONFETTATRICI BASSINE': [
      'Comfit',
      'Comfit Maxi',
      'Spaysystem',
    ],
    'SCIOGLITORI e MISCELATORI': [
      'Tank 200',
      'Tank 400',
    ],
    'ESTRUSORI': [
      'Chocoform',
      'Chiocoliner',
      'Extrudeer',
    ],
    'RAFFINATRICI A SFERE': [
      'Micron 25',
      'Micron 50',
    ],
    'TOSTATRICI': [
      'Tostatrice Roaster 106',
      'Tostatrice Roaster 120',
    ],
    'BEAN TO BAR': [
      'Winnower',
      'Grinder Plus',
      'Conca 100',
      'Conca 200-400',
      'Vaglio',
    ],
    'LAVORAZIONE FRUTTA SECCA': [
      'Grinder Plus',
      'Grain',
      'Vaglio',
    ],
    'FONTANE DI CIOCCOLATO' :[
      'Macchia',
      'Macchia Temperante',
      'Fontana a muro'
    ]
  };

  @override
  Widget build(BuildContext context) {
    final machines = categoryItems[widget.category] ?? [];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: variant),
        backgroundColor: primary,
        title: const Text("Machine", style: TextStyle(color: variant)),
      ),
      body: ListView.builder(
        itemCount: machines.length,
        itemBuilder: (context, index) {
          final isSelected = selectedMachineIndex == index;
          return MachineTile(
            machineName: machines[index],
            isSelected: isSelected,
            onTap: () => _navigateToProductScreen(context, machines[index], index),
          );
        },
      ),
    );
  }

  void _navigateToProductScreen(BuildContext context, String machineName, int index) {
    setState(() => selectedMachineIndex = index);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductMainScreen(
          nome: machineName,
          immagine: "https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato.png",
        ),
      ),
    );
  }
}

class MachineTile extends StatelessWidget {
  final String machineName;
  final bool isSelected;
  final VoidCallback onTap;

  const MachineTile({
    Key? key,
    required this.machineName,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? primary : Colors.transparent,
        child: ListTile(
          title: Text(
            machineName,
            style: TextStyle(
              color: isSelected ? variant : primary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
