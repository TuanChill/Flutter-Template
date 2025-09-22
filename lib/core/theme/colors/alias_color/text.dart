part of 'alias_color.dart';

class _TextOnLight {
  const _TextOnLight();

  final Color primary = GrayColor.gray12; // Color/gray/12
  final Color secondary = GrayColor.gray9; // Color/gray/9
  final Color tertiary = GrayColor.gray7; // Color/gray/7
  final Color disabled = GrayColor.gray8; // Color/gray/8
  final Color highlight1 = PinkColor.pink6; // Color/pink/6 (Primary)
  final Color highlight2 = OrangeColor.primary; // Color/orange/6 (primary)
  final Color brand = CyanColor.cyan7; // Color/cyan/7 (primary)
  final Color darkGreen = NavyColor.navy11; // Color/navy/11
  final Color error = RedColor.red8; // Color/red/8
  final Color warning = OrangeColor.primary; // Color/orange/6 (primary)
  final Color success = GreenColor.green8; // Color/green/8
}

class _TextOnDark {
  const _TextOnDark();

  final Color primary = GrayColor.white; // Color/gray/white
  final Color secondary = GrayColor.gray4; // Color/gray/4
  final Color tertiary = GrayColor.gray6; // Color/gray/6
  final Color highlight = CyanColor.cyan5; // Color/cyan/5
}

class _DSTextOnLight {
  const _DSTextOnLight();

  final Color brandHover = CyanColor.cyan6;
  final Color brandFocus = CyanColor.cyan8;
  final Color disabled = GrayColor.gray8;
  final Color placeholder = GrayColor.gray8;
  final Color link = CyanColor.cyan7;
}

class _DSTextOnDark {
  const _DSTextOnDark();

  final Color disabled = GrayColor.gray6;
}
