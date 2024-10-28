import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prove/Screens/Loading_screen.dart';
import 'package:prove/Colors/color_palette.dart';
import 'package:provider/provider.dart';
import 'model/Object_class.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          headlineMedium: TextStyle(fontSize: 25, color: neutral )
        ),
      ),
      home:  LoadingScreen(),
    );
  }
}

