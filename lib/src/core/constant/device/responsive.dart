import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget smallPhone;
  final Widget mediumPhone;
  final Widget largePhone;
  const Responsive({
    super.key,
    required this.smallPhone,
    required this.mediumPhone,
    required this.largePhone,
  });

  static bool isSmallPhone(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return width <= 360 && height <= 640; // Small phones
  }

  static bool isMediumPhone(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return (width > 360 && width <= 412) && height <= 800; // Medium phones
  }

  static bool isLargePhone(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return width >= 412 && height > 800; // Large phones and phablets
  }

  @override
  Widget build(BuildContext context) {
    if (isSmallPhone(context)) {
      return smallPhone;
    }

    if (isMediumPhone(context)) {
      return mediumPhone;
    }
    if (isLargePhone(context)) {
      return largePhone;
    }
    return largePhone;
  }
}
