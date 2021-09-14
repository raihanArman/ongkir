import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/province_model.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:ongkir/app/modules/home/views/widgets/city.dart';
import 'package:ongkir/app/modules/home/views/widgets/province.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ongkos Kirim'),
          centerTitle: true,
          backgroundColor: Colors.red[900],
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              ProvinceDropdown(
                type: "asal",
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : CityDropdown(
                      provId: controller.provinceIdAsal.value, type: "asal")),
              SizedBox(
                height: 20,
              ),
              ProvinceDropdown(
                type: "tujuan",
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : CityDropdown(
                      provId: controller.provinceIdTujuan.value,
                      type: "tujuan")),
              SizedBox(
                height: 20,
              ),
              BeratBarang(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: DropdownSearch<Map<String, dynamic>>(
                  mode: Mode.MENU,
                  showClearButton: true,
                  items: [
                    {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                    {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
                    {"code": "pos", "name": "POS Indonesia"},
                  ],
                  label: "Tipe Kurir",
                  hint: "pilih tipe kurir",
                  itemAsString: (item) => "${item['name']}",
                  onChanged: (value) {
                    if (value != null) {
                      controller.kurir.value = value["code"];
                      controller.showButton();
                    } else {
                      controller.hiddenButton.value = true;
                      controller.kurir.value = "";
                    }
                  },
                  popupItemBuilder: (context, item, isSelected) => Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${item['name']}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Obx(() => controller.hiddenButton.isTrue
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      child: Text(
                        "Cek Ongkos Kirim",
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          primary: Colors.red[900]),
                    ))
            ],
          ),
        ));
  }
}
