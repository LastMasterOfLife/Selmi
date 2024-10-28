import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<dynamic>> fetchTemperaggioData() async {
  final response = await http.get(
      Uri.parse('https://66f4790377b5e88970999b7c.mockapi.io/selmi/categorie/'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<dynamic>> fetchDocumentiData() async {
  final response = await http.get(
      Uri.parse('https://66f4790377b5e88970999b7c.mockapi.io/selmi/documenti/'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
