import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:ongkir/app/modules/home/province_model.dart';
import 'package:ongkir/app/modules/home/views/widgets/province.dart';

import 'package:http/http.dart' as http;

class CityDropdown extends GetView<HomeController> {
  const CityDropdown({Key? key, required this.provId, required this.type})
      : super(key: key);

  final int provId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      label: type == "asal" ? "Kota/Kabupaten asal" : "Kota/Kabupaten tujuan",
      showSearchBox: true,
      showClearButton: true,
      searchBoxDecoration: InputDecoration(
          hintText: "Cari kota",
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
      onFind: (String filter) async {
        try {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");
          final response = await http
              .get(url, headers: {"key": "534af3096d4dae37b3abd65544347a75"});
          var data = (json.decode(response.body) as Map<String, dynamic>);

          var listOfCity = data["rajaongkir"]["result"] as List<dynamic>;

          var status = data["rajaongkir"]["status"]["code"];

          if (status != 200) {
            throw data["rajaongkir"]["status"]["description"];
          }

          var models = City.fromJsonList(listOfCity);
          return models;
        } catch (err) {
          return List<City>.empty();
        }
      },
      onChanged: (value) {
        if (value != null) {
          if (type == "asal") {
            controller.cityIdAsal.value = int.parse(value.cityId!);
          } else {
            controller.cityIdTujuan.value = int.parse(value.cityId!);
          }
        } else {
          if (type == "asal") {
            print("Tidak memilih Kota asal apapun");
          } else {
            print("Tidak memilih Kota Tujuan apapun");
          }
        }
      },
      popupItemBuilder: (context, item, isSelected) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "${item.type} ${item.cityName}",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      itemAsString: (item) => "${item.type} ${item.cityName}",
    );
  }
}
