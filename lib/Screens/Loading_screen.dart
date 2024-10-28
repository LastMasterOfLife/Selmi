import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Login_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Imposta un controller per l'animazione della barra di caricamento
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Durata della schermata di caricamento
    )..addListener(() {
      setState(() {});
    });

    _controller.forward(); // Avvia il caricamento
    // Passa alla schermata successiva al completamento del caricamento
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen(name: '', surname: '', username: '', emaiil: '', password: '', serialcode: '',)),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Immagine centrata
          Center(
            child: Image.asset(
              'assets/images/selmi_logo.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          // Barra di caricamento in basso al centro
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: LinearProgressIndicator(
              value: _controller.value, // Imposta il valore di avanzamento
              backgroundColor: secondary /*Colors.grey.shade300 */,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

