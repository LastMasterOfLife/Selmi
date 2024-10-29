import 'package:flutter/material.dart';
import 'package:prove/Colors/color_palette.dart';

class ReportMain extends StatefulWidget {
  const ReportMain({super.key});

  @override
  State<ReportMain> createState() => _ReportMainState();
}

class _ReportMainState extends State<ReportMain> {

  final _reportInput = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Riporta gli eroori agli sviluppatori", style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20
          ),),
          buildTextField(_reportInput, 'Report Error'),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
          }, child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text('Send', style: TextStyle(
              fontSize: 25,
            ),),
          ))
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
          maxLines: null,
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
