import 'package:flutter/material.dart';

import '../../introduction_screen.dart';

class OnBoardingConfig {
  final List<PageViewModel>? pages;
  final PageDecoration pageDecoration;
  final Widget? globalHeader;
  final bool showSkipButton;
  final int skipFlex;
  final int nextFlex;
  final Color globalBackgroundColor;
  final GlobalKey introKey;
  final bool rtl;
  final String skipText;
  final Icon nextIcon;
  final String doneText;
  final DotsDecorator? dotsDecorator;
  final ShapeDecoration? dotsContainerDecorator;
  final EdgeInsets? controlsMargin;
  final EdgeInsets? controlsPadding;
  final Curve curve;

  OnBoardingConfig(
      {this.pages,
      required this.pageDecoration,
      this.globalHeader,
      required this.showSkipButton,
      required this.skipFlex,
      required this.nextFlex,
      required this.globalBackgroundColor,
      required this.introKey,
      required this.rtl,
      required this.skipText,
      required this.nextIcon,
      required this.doneText,
      this.dotsDecorator,
      this.dotsContainerDecorator,
      this.controlsMargin,
      this.controlsPadding,
      required this.curve});
}
