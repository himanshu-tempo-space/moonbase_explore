import 'dart:io';

import 'package:flutter/material.dart';

import '../app_constants/app_colors.dart';
import '../app_constants/size_constants.dart';

class TBackArrow extends StatelessWidget {
  const TBackArrow({
    Key? key,
    this.onTap,
    this.bgColor = Colors.white,
    this.arrowColor = purpleColor,
  }) : super(key: key);

  final Function? onTap;
  final Color bgColor;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : () {
              Navigator.of(context).pop();
            },
      child: Container(
        padding: const EdgeInsets.all(TSizeConstants.padding10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(TSizeConstants.radius15),
        ),
        child: Icon(
          Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          size: TSizeConstants.iconSize23,
          color: arrowColor,
        ),
      ),
    );
  }
}
