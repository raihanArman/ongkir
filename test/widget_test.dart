import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response =
      await http.get(url, headers: {"key": "534af3096d4dae37b3abd65544347a75"});
}
