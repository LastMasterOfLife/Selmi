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
  final _nomeText = TextEditingController();
  final _surnameText = TextEditingController();
  final _usernameText = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DATA', style: TextStyle(fontSize: 22, color: primary)),
            SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(width: 10,),
                    Text(widget.name, style:
                    TextStyle(color: primary, fontSize: 25,),
                    textAlign: TextAlign.left,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(width: 10,),
                    Text(widget.surname, style:
                    TextStyle(color: primary, fontSize: 25,),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(width: 10,),
                    Text(widget.emaiil, style:
                    TextStyle(color: primary, fontSize: 25,),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
            SizedBox(height: 360),
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
    );
  }


}
