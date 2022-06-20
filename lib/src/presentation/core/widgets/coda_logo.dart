import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CodaLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const CodaLogo({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return SvgPicture.asset(
      isDarkTheme
          ? 'assets/images/coda-white.svg'
          : 'assets/images/coda-black.svg',
      height: height,
      width: width,
    );
  }
}
