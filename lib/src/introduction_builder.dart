import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/src/bloc/on_boarding_bloc.dart';

import '../introduction_screen.dart';
import '../src/bloc/on_boarding_event.dart';
import '../src/bloc/on_boarding_state.dart';
import 'bloc/on_boarding_bloc.dart';
import 'config/on_boarding_config.dart';

class IntroductionBuilder extends StatelessWidget {
  final Widget widget;
  final OnBoardingConfig boardingConfig;
  final Future<void> Function() saveCache;
  final Future<bool> Function() loadCached;

  const IntroductionBuilder({
    Key? key,
    required this.widget,
    required this.boardingConfig,
    required this.saveCache,
    required this.loadCached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(
        loadCached: loadCached,
        saveCache: saveCache,
      )..add(OnBoardingEvent.checkStatus()),
      child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          return state.when(
            loading: () => CircularProgressIndicator(),
            onBoardingStatus: () => OnBoardingPage(boardingConfig: boardingConfig),
            onWidgetState: () => widget,
          );
        },
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  final OnBoardingConfig boardingConfig;

  const OnBoardingPage({Key? key, required this.boardingConfig}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    context.read<OnBoardingBloc>()..add(OnBoardingEvent.setWidget());
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.boardingConfig;
    return IntroductionScreen(
        key: config.introKey,
        globalBackgroundColor: config.globalBackgroundColor,
        globalHeader: config.globalHeader ?? SizedBox(),
        pages: config.pages,
        onDone: () => _onIntroEnd(context),
        onSkip: config.showSkipButton ? () => _onIntroEnd(context) : null,
        showSkipButton: config.showSkipButton,
        skipFlex: config.skipFlex,
        nextFlex: config.nextFlex,
        rtl: config.rtl,
        skip: Text(config.skipText),
        next: config.nextIcon,
        done: Text(config.doneText, style: TextStyle(fontWeight: FontWeight.w600)),
        curve: config.curve,
        controlsMargin: config.controlsMargin ?? EdgeInsets.all(0),
        controlsPadding: config.controlsPadding ?? EdgeInsets.all(0),
        dotsDecorator: config.dotsDecorator ?? DotsDecorator(),
        dotsContainerDecorator: config.dotsContainerDecorator);
  }
}
