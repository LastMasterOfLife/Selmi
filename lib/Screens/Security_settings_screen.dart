import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:prove/Screens/Account_manager_main_screen.dart';
import '../Texts/Text.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {

  bool _obscureemail = true;
  bool _obscurePass = true;
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  void _togglePasswordVisibilityemail() {
    setState(() {
      _obscureemail = !_obscureemail;
    });
  }

  void _togglePasswordVisibilitypass() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: neutral
        ),
        backgroundColor: primary,
        title: Text('SECURITY', style: TextStyle(color: neutral),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Allinea a sinistra
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Retrieve Sensitive Data',
              style: TextStyle(fontSize: 20, color: primary),
              textAlign: TextAlign.left, // Testo allineato a sinistra
            ),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: buildTextField(_emailInput, 'Email', obscureText: _obscureemail,
              suffixIcon: IconButton(
                icon: Image.asset(
                  _obscureemail
                      ? 'assets/images/eye_off_icon.png'
                      : 'assets/images/eye_on_icon.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: _togglePasswordVisibilityemail,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Change Email', style: TextStyle(color: Colors.grey),),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: buildTextField(_passwordInput,'password',obscureText: _obscurePass,
              suffixIcon: IconButton(
                icon: Image.asset(
                  _obscurePass
                      ? 'assets/images/eye_off_icon.png'
                      : 'assets/images/eye_on_icon.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: _togglePasswordVisibilitypass,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Change Password', style: TextStyle(color: Colors.grey),),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Data Collection Preferences',
              style: TextStyle(fontSize: 22, color: primary),
              textAlign: TextAlign.left, // Testo allineato a sinistra
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountManagerMainScreen(name: '',surname: '',username: '',password: '',serialcode: '',)));
                });
              },
              child: Text(
                'Click Here to Manage Your Data Preferences',
                style: TextStyle(color: secondary , decoration: TextDecoration.underline),
                textAlign: TextAlign.left, // Testo allineato a sinistra
              ),
            ),
          )
        ],
      ),
    );
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
}
