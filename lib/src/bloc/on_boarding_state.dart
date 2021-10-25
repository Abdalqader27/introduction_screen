import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_boarding_state.freezed.dart';

@freezed
class OnBoardingState with _$OnBoardingState {
  const factory OnBoardingState.loading() = OnBoardingLoading;

  const factory OnBoardingState.onBoardingStatus() = OnBoardingStatus;
  const factory OnBoardingState.onWidgetState() = OnWidgetState;
}
