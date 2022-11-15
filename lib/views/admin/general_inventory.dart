import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turks/views/admin/inventory_type_admin.dart';
import 'package:turks/views/admin/product_list_page.dart';
import 'package:turks/views/admin/waste_report_page_admin.dart';
import 'package:turks/widgets/appbar_widget.dart';

import '../../widgets/text_widget.dart';

class GeneralInventory extends StatelessWidget {
  const GeneralInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    List myWidgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            box.write('invenType', 'Ingeredients');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InventoryTypeAdmin()));
          },
          child: Container(
            child: Center(
              child: TextBold(
                  text: 'Ingredients', fontSize: 24, color: Colors.white),
            ),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            box.write('invenType', 'Drinks');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InventoryTypeAdmin()));
          },
          child: Container(
            child: Center(
                child: TextBold(
                    text: 'Drinks', fontSize: 24, color: Colors.white)),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            box.write('invenType', 'Bags');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InventoryTypeAdmin()));
          },
          child: Container(
            child: Center(
                child:
                    TextBold(text: 'Bags', fontSize: 24, color: Colors.white)),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            box.write('invenType', 'Cups');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InventoryTypeAdmin()));
          },
          child: Container(
            child: Center(
                child:
                    TextBold(text: 'Cups', fontSize: 24, color: Colors.white)),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductListPage()));
          },
          child: Container(
            child: Center(
                child: TextBold(
                    text: 'Products', fontSize: 24, color: Colors.white)),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WasteReportPageAdmin()));
          },
          child: Container(
            child: Center(
                child:
                    TextBold(text: 'Waste', fontSize: 24, color: Colors.white)),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget('General Inventory'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/TURKS PNG.png',
              height: 150,
            ),
            Expanded(
              child: SizedBox(
                height: 500,
                child: GridView.builder(
                    itemCount: myWidgets.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return myWidgets[index];
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
