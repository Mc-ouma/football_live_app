import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getFontSize(BuildContext context, double baseFontSize) {
    if (isMobile(context)) {
      return baseFontSize;
    } else if (isTablet(context)) {
      return baseFontSize * 1.2;
    } else {
      return baseFontSize * 1.4;
    }
  }

  static EdgeInsets getPadding(BuildContext context, {double? multiplier}) {
    final factor = multiplier ?? 1.0;
    if (isMobile(context)) {
      return EdgeInsets.all(8.0 * factor);
    } else if (isTablet(context)) {
      return EdgeInsets.all(16.0 * factor);
    } else {
      return EdgeInsets.all(24.0 * factor);
    }
  }
}
