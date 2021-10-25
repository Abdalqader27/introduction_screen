import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_boarding_event.freezed.dart';

@freezed
class OnBoardingEvent with _$OnBoardingEvent {
  const factory OnBoardingEvent.checkStatus() = OnBoardingCheckStatus;

  const factory OnBoardingEvent.setWidget() = OnBoardingSetWidget;
  const factory OnBoardingEvent.setOnBoarding() = OnBoardingSetOnBoarding;
}
