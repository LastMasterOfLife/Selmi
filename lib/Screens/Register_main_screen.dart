import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home_Screen.dart';

class RegisterMainScreen extends StatefulWidget {
  const RegisterMainScreen({super.key});

  @override
  State<RegisterMainScreen> createState() => _RegisterMainScreenState();
}

class _RegisterMainScreenState extends State<RegisterMainScreen> {
  final TextEditingController _nameInput = TextEditingController();
  final TextEditingController _surnameInput = TextEditingController();
  final TextEditingController _usernameInputR = TextEditingController();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInputR = TextEditingController();
  final TextEditingController _serialCodeInput = TextEditingController();

  bool _obscureText = true;

  Future<void> _regist() async {
    // Recupera i dati dagli input
    String name = _nameInput.text;
    String surname = _surnameInput.text;
    String username = _usernameInputR.text;
    String email = _emailInput.text;
    String password = _passwordInputR.text;
    String serialCode = _serialCodeInput.text;

    // Naviga alla schermata di Login
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
            accesso: 'user',
            name: name,
            surname: surname,
            username: username,
            emaiil: email,
            password: password,
            serialcode: serialCode),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    const sizeImage = 24.0;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Column(
            children: [
              buildTextField(_nameInput, "Name"),
              buildTextField(_surnameInput, "Surname"),
              buildTextField(_usernameInputR, "Username"),
              buildTextField(_emailInput, "E-mail"),
              buildTextField(
                _passwordInputR,
                "Password",
                obscureText: true,
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
              buildTextField(_emailInput, "E-mail"),
              ElevatedButton(
                onPressed: _regist,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.5, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: primary, width: 2),
                  ),
                ),
                child: const Text(
                  "Register now",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w200,
                      color: neutral),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
