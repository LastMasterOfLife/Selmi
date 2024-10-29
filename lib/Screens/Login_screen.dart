import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prove/Screens/Home_Screen.dart';
import 'package:prove/Screens/Register_main_screen.dart';
import 'package:prove/ScreensAdmin/Product_main_screen_admin.dart';
import 'package:prove/ScreensGuest/Qr_scan_main_screen_guest.dart';
 //import 'package:shared_preferences/shared_preferences.dart';
import 'package:prove/Colors/color_palette.dart';


class LoginScreen extends StatefulWidget {
  final String name;
  final String surname;
  final String username;
  final String emaiil;
  final String password;
  final String serialcode;
  const LoginScreen(
      {super.key,
      required this.name,
      required this.surname,
      required this.username,
      required this.emaiil,
      required this.password,
      required this.serialcode});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  //late String finaluser;
  //late String finalpass;
  String _data = "Nessun dato ancora"; // Inizializzo il testo di default

  @override
  void initState() {
    super.initState();
    _readData();
  }


  // Funzione per scrivere dati nel database
  Future<void> _writeData() async {
    await _database.child('users').child('user1').set({
      'username': 'ciao',
      'email': 'bello',
    });
    print('Dati scritti nel database!');
  }

  // Funzione per leggere dati dal database
  void _readData() {
    _database.child('users').child('user1').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _data = 'Username: ${data['username']}, Email: ${data['email']}';
        });
      } else {
        setState(() {
          _data = 'Nessun dato trovato nel database!';
        });
      }
    });
  }

  final _passwordInput = TextEditingController();
  final _usernameInput = TextEditingController();
  final String user = 'icts';
  final String admin = 'admin';
  bool _obscureText = true;

  // da mettere a posto
  void _checkInput() {
    final username = _usernameInput.text;
    final password = _passwordInput.text;

    // Assicurati che `finaluser` e `finalpass` siano inizializzati

    if (username == user && password == user) {
      _navigateTo(HomeScreen(
        accesso: 'user',
        name: widget.name,
        surname: widget.surname,
        username: widget.username,
        emaiil: widget.emaiil,
        password: widget.password,
        serialcode: widget.serialcode,
      ));
    } else if (username == admin && password == admin) {
      _navigateTo(HomeScreen(
        accesso: 'admin',
        name: widget.name,
        surname: widget.surname,
        username: widget.username,
        emaiil: widget.emaiil,
        password: widget.password,
        serialcode: widget.serialcode,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Username o Password non validi',
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    }
  }


  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    const sizeImage = 24.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/selmi_logo.png'),
            const SizedBox(
              height: 138,
            ),
            buildTextField(_usernameInput, 'Username', obscureText: false),
            const SizedBox(height: 20),
            buildTextField(
              _passwordInput,
              'Password',
              obscureText: _obscureText,
              suffixIcon: IconButton(
                icon: Image.asset(
                  _obscureText
                      ? 'assets/images/eye_off_icon.png'
                      : 'assets/images/eye_on_icon.png',
                  width: sizeImage,
                  height: sizeImage,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            Expanded(child: Container()),
            _buildButton(
              onPressed: _checkInput,
              text: 'Login',
              color: primary,
              textColor: neutral,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                
                children: [
                  _buildTextButton("Sign up", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterMainScreen()),
                    );
                  }),
                  _buildTextButton("Forgot Password?", () {}),
                  _buildTextButton("Skip", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QrScanMainScreenGuest()),
                    );
                  }, fontSize: 30, isBold: true),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: neutral,
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return SizedBox(
      //width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 2, color: color),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed,
      {double fontSize = 17, bool isBold = false}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero
      ),
      child: Text(
        text,
        style: TextStyle(
          color: secondary,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

Widget buildTextField(TextEditingController controller, String labelText,
    {bool obscureText = false, Widget? suffixIcon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    child: SizedBox(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: primary, fontSize: 23),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintStyle: const TextStyle(color: primary),
          suffixIcon: suffixIcon,
        ),
      ),
    ),
  );
}
