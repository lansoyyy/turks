import 'package:flutter/material.dart';
import 'package:turks/views/admin/product_list_page.dart';
import 'package:turks/views/admin/waste_report_page_admin.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';

import 'inventory_type_admin.dart';

class InventoryAdminPage extends StatelessWidget {
  const InventoryAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('General Inventory'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryTypeAdmin()));
                },
                text: 'Ingredients'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryTypeAdmin()));
                },
                text: 'Drinks'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryTypeAdmin()));
                },
                text: 'Bags'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InventoryTypeAdmin()));
                },
                text: 'Cups'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProductListPage()));
                },
                text: 'Products'),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WasteReportPageAdmin()));
                },
                text: 'Waste'),
          ],
        ),
      ),
    );
  }
}
