import 'package:flutter/material.dart';

enum DeviceScreen { phone, laptop }

DeviceScreen getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth < 600) return DeviceScreen.phone;
  return DeviceScreen.laptop;
}
