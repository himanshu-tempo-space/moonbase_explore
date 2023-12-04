import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'app_colors.dart';

const int snackbarDurationInMilliseconds = 500;

//===============================Error SnackBar=====================================================
void errorTopSnackBar(BuildContext context, String message,
    {int durationInMilliSeconds = snackbarDurationInMilliseconds}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: message, maxLines: 5),
    displayDuration: Duration(milliseconds: durationInMilliSeconds),
  );
}

//===================================Top SnackBar====================================================
void infoTopSnackBar(BuildContext context, String message,
    {int durationInMilliSeconds = snackbarDurationInMilliseconds}) {
  showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message: message, maxLines: 5, backgroundColor: purpleColor),
      displayDuration: Duration(milliseconds: durationInMilliSeconds));
}

//=================================Success SnackBar====================================================
void successTopSnackBar(BuildContext context, String message,
    {int durationInMilliSeconds = snackbarDurationInMilliseconds}) {
  showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: message, maxLines: 5),
      displayDuration: Duration(milliseconds: durationInMilliSeconds));
}
