import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget showImage(
  String path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  final extension = path.split('.').last.toLowerCase();

  switch (extension) {
    case 'svg':
      return SvgPicture.asset(path, width: width, height: height, fit: fit);

    case 'png':
    case 'jpg':
    case 'jpeg':
    case 'gif':
    case 'webp':
    case 'bmp':
    case 'wbmp':
    case 'ico':
    case 'tif':
    case 'tiff':
    case 'avif':
    case 'heic':
    case 'heif':
      return Image.asset(path, width: width, height: height, fit: fit);

    default:
      return const SizedBox.shrink();
  }
}
