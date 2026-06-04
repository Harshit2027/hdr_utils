import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  bool get isLightMode => theme.brightness == Brightness.light;

  double get bodyHeight => mediaQuery.size.height - bottomPadding - topPadding;

  double get topPadding => mediaQuery.padding.top;

  double get bottomPadding => mediaQuery.padding.bottom;

  double get topInset => mediaQuery.viewInsets.top;

  double get bottomInset => mediaQuery.viewInsets.bottom;

  MediaQueryData get mediaQuery {
    debugCheckHasMediaQuery(this);
    return MediaQuery.of(this);
  }

  EdgeInsets get mediaQueryPadding {
    debugCheckHasMediaQuery(this);
    return MediaQuery.paddingOf(this);
  }

  EdgeInsets get mediaQueryViewPadding {
    debugCheckHasMediaQuery(this);
    return MediaQuery.viewPaddingOf(this);
  }

  EdgeInsets get mediaQueryInsets {
    debugCheckHasMediaQuery(this);
    return MediaQuery.viewInsetsOf(this);
  }

  TextScaler get textScaler {
    debugCheckHasMediaQuery(this);
    return MediaQuery.textScalerOf(this);
  }

  Orientation get orientation {
    debugCheckHasMediaQuery(this);
    return MediaQuery.orientationOf(this);
  }

  double get height {
    debugCheckHasMediaQuery(this);
    return MediaQuery.sizeOf(this).height;
  }

  double get width {
    debugCheckHasMediaQuery(this);
    return MediaQuery.sizeOf(this).width;
  }

  TextDirection get textDirection {
    debugCheckHasDirectionality(this);
    return Directionality.of(this);
  }

  Locale get locale => Localizations.localeOf(this);

  bool get lightTheme => theme.brightness == Brightness.light;

  void hideKeyboard() {
    final FocusScopeNode focusScope = FocusScope.of(this);
    if (!focusScope.hasPrimaryFocus && focusScope.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  NavigatorState get navigator => Navigator.of(this);

  Object? get args => ModalRoute.of(this)?.settings.arguments;

  T getArguments<T extends Object?>() {
    assert(args is T);
    return args as T;
  }
}
