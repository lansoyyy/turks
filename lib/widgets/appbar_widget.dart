import 'package:flutter/material.dart';
import 'package:turks/widgets/text_widget.dart';

import '../utils/colors.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    backgroundColor: secondaryColor,
    title: TextRegular(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
