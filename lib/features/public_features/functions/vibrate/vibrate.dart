import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../widget/snack_bar_widget.dart';

Future<void> vibrateDevice({required BuildContext context,required String errorMsg}) async {
  final hasVibrator = await Vibration.hasVibrator();
  if (hasVibrator != null && hasVibrator) {
    await Vibration.vibrate(duration: 200);
    getSnackBarWidget(context, errorMsg, Colors.red);
  } else {
    getSnackBarWidget(context, errorMsg, Colors.red);
  }
}
