import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
              autocorrect: false,
              controller: controller.beratC,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: "Berat Barang",
                  border: OutlineInputBorder(),
                  hintText: "Masukkan Berat"),
              onChanged: (value) => controller.ubahBerat(value)),
        ),
        SizedBox(width: 10),
        Container(
          width: 150,
          child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                  hintText: "Cari satuan berat", border: OutlineInputBorder()),
              items: [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              label: "Satuan",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) => controller.ubahSatuan(value!),
              selectedItem: "gram"),
        )
      ],
    );
  }
}
