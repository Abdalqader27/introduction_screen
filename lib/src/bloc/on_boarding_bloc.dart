import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'on_boarding_event.dart';
import 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final Future<void> Function() saveCache;
  final Future<bool> Function() loadCached;

  OnBoardingBloc({required this.saveCache, required this.loadCached}) : super(const OnBoardingState.loading()) {
    on<OnBoardingEvent>((event, emit) {
      event.when(
        checkStatus: () async {
          bool status = await getCacheOnBoarding();
          if (status) {
            emit(const OnBoardingState.onBoardingStatus());
          } else {
            emit(const OnBoardingState.onWidgetState());
          }
        },
        setWidget: () async {
          await setCacheOnBoarding();
          emit(const OnBoardingState.onWidgetState());
        },
        setOnBoarding: () {
          emit(OnBoardingState.onBoardingStatus());
        },
      );
    });
  }

  @override
  void onTransition(Transition<OnBoardingEvent, OnBoardingState> transition) {
    super.onTransition(transition);
    debugPrint(transition.currentState.runtimeType.toString());
  }

  Future<bool> getCacheOnBoarding() async {
    return loadCached();
  }

  Future<void> setCacheOnBoarding() async {
    return saveCache();
  }
}
