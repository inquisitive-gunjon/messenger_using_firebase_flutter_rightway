

import 'package:flutter/material.dart';

ButtonStyle appButtonStyle() {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12))
  );
}