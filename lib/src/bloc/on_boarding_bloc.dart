import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import 'on_boarding_event.dart';
import 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  static const String check = 'checkOnBoarding';

  OnBoardingBloc() : super(const OnBoardingState.loading()) {
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
    final box = GetStorage();
    final status = box.read(check) ?? true;
    debugPrint("$status");
    return status;
  }

  Future<void> setCacheOnBoarding() async {
    debugPrint("setCache");
    final box = GetStorage();
    box.write(check, false);
  }
}
