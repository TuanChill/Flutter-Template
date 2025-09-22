part of 'alias_color.dart';

class _IconOnLight {
  const _IconOnLight();

  final Color primary = NavyColor.navy11; // Text/on light/dark green
  final Color secondary = GrayColor.gray9; // Text/on light/secondary
  final Color tertiary = GrayColor.gray7; // Text/on light/tertiary
  final Color brand = CyanColor.cyan7; // Text/on light/brand
  final Color highlight1 = PinkColor.pink6; // Text/on light/highlight 1
  final Color highlight2 = OrangeColor.primary; // Text/on light/highlight 2
  final Color error = RedColor.red8; // Text/on light/error
  final Color warning = OrangeColor.primary; // Text/on light/warning
  final Color success = GreenColor.green8; // Text/on light/success
}

class _IconOnDark {
  const _IconOnDark();

  final Color primary = GrayColor.white; // Text/on dark/primary
  final Color secondary = GrayColor.gray4; // Text/on dark/secondary
  final Color tertiary = GrayColor.gray6; // Text/on dark/tertiary
  final Color cyan = CyanColor.cyan5; // Text/on dark/highlight
}

class _DSIconOnLight {
  const _DSIconOnLight();

  final Color brandHover = CyanColor.cyan6;
  final Color brandFocus = CyanColor.cyan8;
  final Color disabled = GrayColor.gray8;
  final Color link = CyanColor.cyan7;
}

class _DSIconOnDark {
  const _DSIconOnDark();

  final Color disabled = GrayColor.gray6;
}
