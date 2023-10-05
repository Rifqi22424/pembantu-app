import 'package:flutter/widgets.dart';

deviceTypeTablet() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
   return data.size.width >= 1024 && data.size.height >= 768 ? true : false;
}
