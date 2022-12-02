import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  SizeConfig._();
  static final instance = SizeConfig._();
  MediaQueryData? _mediaQueryData;
  double screenWidth = 0;
  double screenHeight = 0;
  static Orientation orientation = Orientation.portrait;
  bool hasInit = false;

  Future<void> init(BuildContext context) async {
    if (hasInit) return;
    await Future.delayed(const Duration(milliseconds: 300));
    _mediaQueryData = MediaQuery.of(context);
    if (!_initMediaQuerry) {
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return _initMediaQuerry;
      });
    }
    screenWidth = _mediaQueryData!.size.width;

    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    hasInit = true;
  }

  bool get _initMediaQuerry {
    if (_mediaQueryData == null) return false;
    return _mediaQueryData!.size.height > 100 &&
        _mediaQueryData!.size.width > 100;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.instance.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.instance.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getPercentScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.instance.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 100) * screenWidth;
}

double getPercentScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.instance.screenHeight;
  // 375 is the layout width that designer use
  return (inputHeight / 100) * screenHeight;
}

double getFlexiblePadding(BuildContext context, [double staticPadding = 1]) {
  double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  bool keyboardOn = keyboardHeight > 1;
  double bottomPadding = keyboardOn ? keyboardHeight : staticPadding;
  return bottomPadding;
}


/*// Full screen width and height
double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

// Height (without SafeArea)
var padding = MediaQuery.of(context).viewPadding;
double height1 = height - padding.top - padding.bottom;

// Height (without status bar)
double height2 = height - padding.top;

// Height (without status and toolbar)
double height3 = height - padding.top - kToolbarHeight;*/