import 'package:flutter/material.dart';

part 'background.dart';
part 'text.dart';
part 'divider.dart';
part 'border.dart';
part 'icon.dart';

abstract class AliasColor {
  static const background = _Background();
  static const divider = _DividerColor();
  static const border = _BorderColor();
  static const textOnLight = _TextOnLight();
  static const textOnDark = _TextOnDark();
  static const iconOnLight = _IconOnLight();
  static const iconOnDark = _IconOnDark();
}

abstract class DSColor {
  static const background = _DSBackground();
  static const border = _DSBorderColor();
  static const textOnLight = _DSTextOnLight();
  static const textOnDark = _DSTextOnDark();
  static const iconOnLight = _DSIconOnLight();
  static const iconOnDark = _DSIconOnDark();
}

abstract class GradientColor {
  static const Gradient orange = LinearGradient(
    colors: [Color(0xffFF903D), Color(0xFFF5AF06)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient orange2 = LinearGradient(
    colors: [Color(0xFFF5AF06), Color(0xffFF903D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient cyan = LinearGradient(
    colors: [Color(0xff01B5B4), Color(0xff02A09F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient yellow = LinearGradient(
    colors: [Color(0xffFFBD14), Color(0xffF16D23)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient pink3 = LinearGradient(
    colors: [Color(0xFFFF5A97), Color(0xffFA357D), Color(0xffF51975)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

abstract class InteractionColor {
  static const Color hover = Color(0x1AFFFFFF); // White with 10% opacity
  static const Color pressed = Color(0x1A000000); // Black with 10% opacity
}

abstract class BlueColor {
  static const Color blue1 = Color(0xFFF1F7FF);
  static const Color blue2 = Color(0xFFEBF4FF);
  static const Color blue3 = Color(0xFFE0EEFF);
  static const Color blue4 = Color(0xFFB6D7FF);
  static const Color blue5 = Color(0xFF7AB6FF);
  static const Color blue6 = Color(0xFF3D95FF);
  static const Color blue7 = Color(0xFF006EF5);
  static const Color blue8 = Color(0xFF0065E0);
  static const Color blue9 = Color(0xFF004EAE);
  static const Color blue10 = Color(0xFF003F8C);
  static const Color blue11 = Color(0xFF042A59);
}

abstract class GrayColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray1 = Color(0xFFFBFCFD);
  static const Color gray2 = Color(0xFFFAFBFB);
  static const Color gray3 = Color(0xFFF3F5F7);
  static const Color gray4 = Color(0xFFE0E5EB);
  static const Color gray5 = Color(0xFFCAD4DE);
  static const Color gray6 = Color(0xFFB6C3D1);
  static const Color gray7 = Color(0xFFA4B3C3);
  static const Color gray8 = Color(0xFF758CA3);
  static const Color gray9 = Color(0xFF455768);
  static const Color gray10 = Color(0xFF303D49);
  static const Color gray11 = Color(0xFF252F38);
  static const Color gray12 = Color(0xFF101519);
  static const Color black = Color(0xFF030303);
}

abstract class GreenColor {
  static const Color green1 = Color(0xFFF6FEF9);
  static const Color green2 = Color(0xFFDEFCEA);
  static const Color green3 = Color(0xFFD1FADF);
  static const Color green4 = Color(0xFFA6F4C5);
  static const Color green5 = Color(0xFF6CE9A6);
  static const Color green6 = Color(0xFF32D583);
  static const Color green7 = Color(0xFF12B76A);
  static const Color green8 = Color(0xFF039855);
  static const Color green9 = Color(0xFF027A48);
  static const Color green10 = Color(0xFF05603A);
}

abstract class OverlayColor {
  static const Color white20 = Color(0x33FFFFFF); // White 20%
  static const Color white8 = Color(0x14FFFFFF); // White 8%
  static const Color white30 = Color(0x4DFFFFFF); // White 30%
  static const Color white50 = Color(0x80FFFFFF); // White 50%
  static const Color white70 = Color(0xB3FFFFFF); // White 70%
  static const Color black20 = Color(0x33000000); // Black 20%
  static const Color black40 = Color(0x66000000); // Black 40%
}

abstract class CyanColor {
  static const Color cyan1 = Color(0xFFF2FBFC);
  static const Color cyan2 = Color(0xFFEEF9FB);
  static const Color cyan3 = Color(0xFFE6F7FA);
  static const Color cyan4 = Color(0xFFA2E7EB);
  static const Color cyan5 = Color(0xFF2DD2D2);
  static const Color cyan6 = Color(0xFF00BBBA);
  static const Color cyan7 = Color(0xFF1D8787); // cyan7
  static const Color cyan8 = Color(0xFF176D6D);
  static const Color cyan9 = Color(0xFF125454);
  static const Color cyan10 = Color(0xFF0C3B3B);
  static const Color cyan11 = Color(0xFF0C3B3B); // Same as cyan10
}

abstract class NavyColor {
  static const Color navy1 = Color(0xFFF1F9FD);
  static const Color navy2 = Color(0xFFEDF7FD);
  static const Color navy3 = Color(0xFFDCEFFA);
  static const Color navy4 = Color(0xFFC0E3F7);
  static const Color navy5 = Color(0xFF8ACAF0);
  static const Color navy6 = Color(0xFF53B2E9);
  static const Color navy7 = Color(0xFF1C94D9);
  static const Color navy8 = Color(0xFF1A87C7);
  static const Color navy9 = Color(0xFF146999);
  static const Color navy10 = Color(0xFF10537A);
  static const Color navy11 = Color(0xFF082A3E);
}

abstract class PinkColor {
  static const Color pink1 = Color(0xFFFFF0F7);
  static const Color pink2 = Color(0xFFFFEBF5);
  static const Color pink3 = Color(0xFFFEE1EF);
  static const Color pink4 = Color(0xFFFD91C6);
  static const Color pink5 = Color(0xFFFB419C);
  static const Color pink6 = Color(0xFFFB3093); // pink6
  static const Color pink7 = Color(0xFFF5057B);
  static const Color pink8 = Color(0xFFC30462);
  static const Color pink9 = Color(0xFF910349);
  static const Color pink10 = Color(0xFF5F0230);
}

abstract class YellowColor {
  static const Color yellow1 = Color(0xFFFFFCE6);
  static const Color yellow2 = Color(0xFFFEF5B2);
  static const Color yellow3 = Color(0xFFFEF18C);
  static const Color yellow4 = Color(0xFFFEEA58);
  static const Color yellow5 = Color(0xFFFDE638);
  static const Color yellow6 = Color(0xFFFDE006); // yellow6
  static const Color yellow7 = Color(0xFFE6CC05);
  static const Color yellow8 = Color(0xFFB49F04);
  static const Color yellow9 = Color(0xFF8B7B03);
  static const Color yellow10 = Color(0xFF6A5E03);
}

abstract class OrangeColor {
  static const Color orange1 = Color(0xFFFFFAF5);
  static const Color orange2 = Color(0xFFFFF0E1);
  static const Color orange3 = Color(0xFFFEE3C7);
  static const Color orange4 = Color(0xFFFEC389);
  static const Color orange5 = Color(0xFFFEA44B);
  static const Color primary = Color(0xFFFD8206); // orange6
  static const Color orange7 = Color(0xFFED7A08);
  static const Color orange8 = Color(0xFFDC7003);
  static const Color orange9 = Color(0xFFB05C07);
  static const Color orange10 = Color(0xFF83470B);
  static const Color orange11 = Color(0xFFFFDBB8);
}

abstract class RedColor {
  static const Color red1 = Color(0xFFFFFBFA);
  static const Color red2 = Color(0xFFFEF3F2);
  static const Color red3 = Color(0xFFFEE4E2);
  static const Color red4 = Color(0xFFFFCDCA);
  static const Color red5 = Color(0xFFFDA29B);
  static const Color red6 = Color(0xFFFA7066);
  static const Color red7 = Color(0xFFF04438);
  static const Color red8 = Color(0xFFD92D20);
  static const Color red9 = Color(0xFFB42318);
  static const Color red10 = Color(0xFF912018);
  static const Color red11 = Color(0xFFF84125);
}
