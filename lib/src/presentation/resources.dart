import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class R {
  static const color = _Colors();
  static const icon = _Icons();
  static const image = _Images();
  static const font = _Fonts();
  static const dimen = _Dimens();
}

// TODO generate
class _Colors {
  const _Colors();

  final white = const Color(0xffffffff);
  final whiteSmoke = const Color(0xfff4f4f4);
  final whisper = const Color(0xffebebeb);

  final licorice = const Color(0xff303943);

  final shamrock = const Color(0xff2cdab1);
  final puertoRico = const Color(0xff4fc1a6);

  final salmon = const Color(0xfff7786b);
  final bittersweet = const Color(0xfffa6555);

  final malibu = const Color(0xff58abf6);
  final summerSky = const Color(0xff429bed);

  final kournikova = const Color(0xffffce4b);
  final creamCan = const Color(0xfff6c747);

  final affair = const Color(0xff7c538c);
  final deepLilac = const Color(0xff9f5bba);

  final coralTree = const Color(0xffb1736c);
  final myPink = const Color(0xffca8179);
}

class _Icons {
  const _Icons();

  final search = FontAwesomeIcons.search;
}

class _Images {
  const _Images();

  static const assetPath = 'assets/images';

  final pokeball = '$assetPath/pokeball.png';
}

class _Fonts {
  const _Fonts();

  final circularStd = 'CircularStd';
}

class _Dimens {
  const _Dimens();

  final horizontalPadding = 24.0;
}
