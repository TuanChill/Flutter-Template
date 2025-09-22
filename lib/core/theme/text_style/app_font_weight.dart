import 'dart:ui';
import 'package:path/path.dart' as p;

class STCDTFontWeight {
  const STCDTFontWeight({
    required this.fontWeight,
    required this.fontFamily,
  });

  final FontWeight fontWeight;
  final String fontFamily;

  String get packageFontFamily => p.join(
        'packages',
        'stcdt_ui',
        fontFamily,
      );

  static const STCDTFontWeight bold = STCDTFontWeight(
    fontWeight: FontWeight.w700,
    fontFamily: 'Inter',
  );

  static const STCDTFontWeight semi = STCDTFontWeight(
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );

  static const STCDTFontWeight medium = STCDTFontWeight(
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );

  static const STCDTFontWeight regular = STCDTFontWeight(
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  static const STCDTFontWeight light = STCDTFontWeight(
    fontWeight: FontWeight.w300,
    fontFamily: 'Inter',
  );

  static const STCDTFontWeight thin = STCDTFontWeight(
    fontWeight: FontWeight.w100,
    fontFamily: 'Inter',
  );
}
