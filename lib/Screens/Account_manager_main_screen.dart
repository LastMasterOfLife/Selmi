import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';

class AccountManagerMainScreen extends StatefulWidget {
  final name;
  final surname;
  final username;
  final emaiil;
  final password;
  final serialcode;
  const AccountManagerMainScreen({super.key, this.name, this.surname, this.username, this.emaiil, this.password, this.serialcode});

  @override
  State<AccountManagerMainScreen> createState() => _AccountManagerMainScreenState();
}

class _AccountManagerMainScreenState extends State<AccountManagerMainScreen> {

  bool _obscureText = true;
  final _nomeText = TextEditingController();
  final _surnameText = TextEditingController();
  final _usernameText = TextEditingController();

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
        iconTheme: IconThemeData(
          color: neutral,
        ),
        backgroundColor: primary,
        title: Text(
          'ACCOUNT MANAGER',
          style: TextStyle(color: neutral),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Account', style: TextStyle(fontSize: 22, color: primary)),
              SizedBox(height: 20),
              buildTextField(_nomeText, 'Name', widget.name, obscureText: false),
              SizedBox(height: 10),
              buildTextField(_surnameText, 'Surname',widget.surname, obscureText: true,
                suffixIcon: IconButton(
                  icon: Image.asset(
                    _obscureText
                        ? 'assets/images/eye_off_icon.png'
                        : 'assets/images/eye_on_icon.png',
                    width: sizeImage,
                    height: sizeImage,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),),
              SizedBox(height: 10),
              buildTextField(_usernameText, 'Username',widget.username, obscureText:  true,
                suffixIcon: IconButton(
                icon: Image.asset(
                  _obscureText
                      ? 'assets/images/eye_off_icon.png'
                      : 'assets/images/eye_on_icon.png',
                  width: sizeImage,
                  height: sizeImage,
                ),
                onPressed: _togglePasswordVisibility,
              ),),
              SizedBox(height: 290,),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: error, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText, String text,
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
            hintText: text,
            hintStyle: const TextStyle(color: primary),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
