part of 'alias_color.dart';

class _BorderColor {
  const _BorderColor();

  final Color gray = GrayColor.gray5; // _Only DS/Border/_default
  final Color grayLighter = GrayColor.gray4;
  final Color white = GrayColor.white;
  final Color white80 = OverlayColor.white8; // white-0,8 trong ảnh
  final Color brand = CyanColor.cyan7;
  final Color warning = YellowColor.yellow7;
  final Color error = RedColor.red8;
  final Color success = GreenColor.green7;
}

class _DSBorderColor {
  const _DSBorderColor();

  final Color $default = GrayColor.gray5;
  final Color disabled = GrayColor.gray4;
  final Color brandHover = CyanColor.cyan4;
  final Color brandFocus = CyanColor.cyan8;
}
