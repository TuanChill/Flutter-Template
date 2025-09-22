import 'package:flutter/material.dart';

import 'app_font_weight.dart';

class TextStyleWidget extends TextStyle {
  const TextStyleWidget({
    required this.stcdtFontWeight,
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing = 0,
    super.wordSpacing = 0,
    super.textBaseline,
    super.height = 1,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamily,
    super.fontFamilyFallback,
    String? package,
    super.fontVariations,
    super.overflow,
  }) : super(
          package: package ?? 'stcdt_ui',
        );

  final STCDTFontWeight stcdtFontWeight;

  @override
  String get fontFamily => stcdtFontWeight.packageFontFamily;

  @override
  FontWeight get fontWeight => stcdtFontWeight.fontWeight;

  Text text(
    String data, {
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    TextScaler? textScaler,
  }) =>
      Text(
        data,
        style: this,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        textScaler: textScaler,
      );

  Text rich(
    InlineSpan textSpan, {
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    TextScaler? textScaler,
  }) =>
      Text.rich(
        textSpan,
        style: this,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        textScaler: textScaler,
      );
}

class RegularTextStyle extends TextStyleWidget {
  const RegularTextStyle({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontStyle,
    super.letterSpacing = 0,
    super.wordSpacing = 0,
    super.textBaseline,
    super.height = 1,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamilyFallback,
    super.overflow,
  }) : super(stcdtFontWeight: STCDTFontWeight.regular);
}

class SemiTextStyle extends TextStyleWidget {
  const SemiTextStyle({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontStyle,
    super.letterSpacing = 0,
    super.wordSpacing = 0,
    super.textBaseline,
    super.height = 1,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamilyFallback,
    super.overflow,
  }) : super(stcdtFontWeight: STCDTFontWeight.semi);
}

class MediumTextStyle extends TextStyleWidget {
  const MediumTextStyle({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontStyle,
    super.letterSpacing = 0,
    super.wordSpacing = 0,
    super.textBaseline,
    super.height = 1,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamilyFallback,
    super.overflow,
  }) : super(stcdtFontWeight: STCDTFontWeight.medium);
}

class BoldTextStyle extends TextStyleWidget {
  const BoldTextStyle({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontStyle,
    super.letterSpacing = 0,
    super.wordSpacing = 0,
    super.textBaseline,
    super.height = 1,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamilyFallback,
    super.overflow,
  }) : super(stcdtFontWeight: STCDTFontWeight.bold);
}
