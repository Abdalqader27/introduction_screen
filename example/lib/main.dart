import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() async {
  await GetStorage.init();

  runApp(App());
}

class App extends StatelessWidget {
  static const String check = 'checkOnBoarding';

  bool getCached() {
    final box = GetStorage();
    final status = box.read(check) ?? true;
    debugPrint("$status");
    return status;
  }

  Future<void> saveCached() async {
    debugPrint("setCache");
    final box = GetStorage();
    box.write(check, false);
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    final dotDecoration = const DotsDecorator(
      size: Size(10.0, 10.0),
      color: Color(0xFFBDBDBD),
      activeSize: Size(22.0, 10.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
    final globalHeader = Align(
      alignment: Alignment.topRight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: Icon(Icons.check),
        ),
      ),
    );
    final pages = [
      PageViewModel(
        title: "Fractional shares",
        body: "Instead of having to buy an entire share, invest any amount you want.",
        image: _buildImage('img1.jpg'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Learn as you go",
        body: "Download the Stockpile app and master the market with our mini-lesson.",
        image: _buildImage('img2.jpg'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Kids and teens",
        body: "Kids and teens can track their stocks 24/7 and place trades that you approve.",
        image: _buildImage('img3.jpg'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Full Screen Page",
        body:
            "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
        image: _buildFullscrenImage(),
        decoration: pageDecoration.copyWith(
          contentMargin: const EdgeInsets.symmetric(horizontal: 16),
          fullScreen: true,
          bodyFlex: 2,
          imageFlex: 3,
        ),
      ),
      PageViewModel(
        title: "Another title page",
        body: "Another beautiful body text for this example onboarding",
        image: _buildImage('img2.jpg'),
        footer: ElevatedButton(
          onPressed: () {
            introKey.currentState?.animateScroll(0);
          },
          child: const Text(
            'FooButton',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Title of last page - reversed",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Click on ", style: bodyStyle),
            Icon(Icons.edit),
            Text(" to edit a post", style: bodyStyle),
          ],
        ),
        decoration: pageDecoration.copyWith(
          bodyFlex: 2,
          imageFlex: 4,
          bodyAlignment: Alignment.bottomCenter,
          imageAlignment: Alignment.topCenter,
        ),
        image: _buildImage('img1.jpg'),
        reverse: true,
      ),
    ];
    final dotContainerDecoration = const ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    );

    final OnBoardingConfig _config = OnBoardingConfig(
        introKey: introKey,
        globalHeader: globalHeader,
        dotsDecorator: dotDecoration,
        controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        controlsMargin: const EdgeInsets.all(16),
        nextIcon: const Icon(Icons.arrow_forward),
        showSkipButton: true,
        skipText: "Skip",
        nextFlex: 0,
        globalBackgroundColor: Colors.white,
        skipFlex: 0,
        doneText: "Done",
        rtl: false,
        pageDecoration: pageDecoration,
        curve: Curves.fastLinearToSlowEaseIn,
        dotsContainerDecorator: dotContainerDecoration,
        pages: pages);
    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IntroductionBuilder(
        loadCached: () async => getCached(),
        saveCache: saveCached,
        boardingConfig: _config,
        widget: Scaffold(),
      ),
    );
  }
}
