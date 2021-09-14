import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:ongkir/app/modules/home/province_model.dart';

import 'package:http/http.dart' as http;

class ProvinceDropdown extends GetView<HomeController> {
  const ProvinceDropdown({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
      label: type == "asal" ? "Provisi asal" : "Provinsi tujuan",
      showClearButton: true,
      showSearchBox: true,
      searchBoxDecoration: InputDecoration(
          hintText: "Cari provinsi",
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
      onFind: (String filter) async {
        try {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          final response = await http
              .get(url, headers: {"key": "534af3096d4dae37b3abd65544347a75"});
          var data = (json.decode(response.body) as Map<String, dynamic>);

          var listOfProvince = data["rajaongkir"]["result"] as List<dynamic>;

          var status = data["rajaongkir"]["status"]["code"];

          if (status != 200) {
            throw data["rajaongkir"]["status"]["description"];
          }

          var models = Province.fromJsonList(listOfProvince);
          return models;
        } catch (err) {
          return List<Province>.empty();
        }
      },
      onChanged: (value) {
        if (value != null) {
          if (type == "asal") {
            controller.hiddenKotaAsal.value = false;
            controller.provinceIdAsal.value = value.provinceId!;
            print(value.province);
          } else {
            controller.hiddenKotaTujuan.value = false;
            controller.provinceIdTujuan.value = value.provinceId!;
          }
        } else {
          if (type == "asal") {
            controller.hiddenKotaAsal.value = true;
            controller.provinceIdAsal.value = 0;
          } else {
            controller.hiddenKotaTujuan.value = false;
            controller.provinceIdTujuan.value = 0;
          }
          print("Tidak memilih province apapun");
        }
      },
      popupItemBuilder: (context, item, isSelected) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "${item.province}",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      itemAsString: (item) => item.province!,
    );
  }
}
