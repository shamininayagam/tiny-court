import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' as collection;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import '../../intl/i18n.dart';
import '../../ui/tokens/app_colors.dart';
import 'app_theme.dart';

extension StringUtils on String {
  Key toKey() => Key(this);

  ValueKey<String> toValueKey() => ValueKey<String>(this);

  ReCase get _recase => ReCase(this);

  String camelCase() => _recase.camelCase;

  String constantCase() => _recase.constantCase;

  String sentenceCase() => _recase.sentenceCase;

  String snakeCase() => _recase.snakeCase;

  String dotCase() => _recase.dotCase;

  String paramCase() => _recase.paramCase;

  String pathCase() => _recase.pathCase;

  String pascalCase() => _recase.pascalCase;

  String headerCase() => _recase.headerCase;

  String titleCase() => _recase.titleCase;
}

extension NumberUtils on num {
  static const int _width = 375; // reference width from designs
  // ignore: unused_field
  static const int _height = 800;

  double responsive(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final double scaleFactor = data.size.shortestSide / _width;
    final double responsive = this * scaleFactor;
    return responsive;
  }
}

extension TextStyleUtils on TextStyle {
  TextStyle get responsive => copyWith(fontSize: fontSize);

  Widget withText(String text, {TextAlign align = TextAlign.center}) => Text(
        text,
        textAlign: align,
        style: this,
      );

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withSize(double size) => copyWith(fontSize: size);
}

extension ListWidgetUtils on List<Widget> {
  List<Widget> mapPadding({
    required EdgeInsets padding,
  }) {
    return map((Widget child) {
      return Padding(
        padding: padding,
        child: child,
      );
    }).toList();
  }

  List<Widget> mapWithDivider({
    required EdgeInsets padding,
  }) {
    return map((Widget child) {
      return Padding(
        padding: padding,
        child: Column(children: <Widget>[
          child,
          Divider(
            thickness: 0.5,
            color: Colors.black.withValues(alpha: 0.25),
          ),
        ]),
      );
    }).toList();
  }
}

extension IterableUtils<T> on Iterable<T> {
  List<Widget> mapToWidget(Widget Function(T) mapper) {
    return map<Widget>(mapper).toList();
  }
}

extension ListUtils<T> on List<T> {
  Map<S, List<T>> groupBy<S>(S Function(T) mapper) {
    return collection.groupBy<T, S>(this, mapper);
  }
}

extension BuiltListUtils<T> on BuiltList<T> {
  List<Widget> mapToWidget(Widget Function(T) mapper) {
    return map<Widget>(mapper).toList();
  }

  Map<S, List<T>> groupBy<S>(S Function(T) mapper) {
    return collection.groupBy<T, S>(this, mapper);
  }
}

extension SizeUtils on Size {
  Size responsive(BuildContext context) => Size(
        width.responsive(context),
        height.responsive(context),
      );
}

extension BuildContextUtils on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get mediaSize => mediaQuery.size;

  ThemeData get theme => Theme.of(this);

  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  TextTheme get primaryTextTheme => theme.primaryTextTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  ButtonThemeData get buttonTheme => ButtonTheme.of(this);

  IconThemeData get iconTheme => IconTheme.of(this);

  AppStrings get strings => AppLocalizations.of(this);

  AppColors get colors => isDarkTheme ? const AppDarkColors() : const AppLightColors();

  ModalRoute<T>? getModalRoute<T>() => ModalRoute.of<T>(this);

  NavigatorState get rootNavigator => Navigator.of(this, rootNavigator: true);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension ErrorUtils on BuildContext {
  Future<void> handleError(Object error, [StackTrace? stackTrace]) async {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          error.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }

  Future<void> handleErrorDialog(Object error, [StackTrace? stackTrace]) async {
    return showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oops!'),
          content: Text('$error\n$stackTrace'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => navigator.pop(),
            ),
          ],
        );
      },
    );
  }
}

extension DateExtensions on DateTime? {
  String formatYMMM() {
    if (this == null) {
      return '';
    }
    return DateFormat.yMMM().format(this!);
  }

  String formatYMMMM() {
    if (this == null) {
      return '';
    }
    return DateFormat.yMMMM().format(this!);
  }

  String formatMMDDYYYY() {
    if (this == null) {
      return '';
    }
    return DateFormat.yMMMd().format(this!);
  }
}

typedef ValidatorFunction = String? Function(String? value);

extension Validators on BuildContext {
  ValidatorFunction chainValidators(List<ValidatorFunction> validators) {
    return (String? value) {
      for (final ValidatorFunction validator in validators) {
        final String? error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  String? isNotEmptyValidator(String? value) {
    return (value?.isEmpty ?? true) ? strings.cannotBeEmpty : null;
  }

  ValidatorFunction get mobileNumberValidator {
    return chainValidators(<String? Function(String?)>[
      isNotEmptyValidator,
      _mobileNumberValidator,
    ]);
  }

  ValidatorFunction get emailValidator {
    return chainValidators(<String? Function(String?)>[
      isNotEmptyValidator,
      _emailValidator,
    ]);
  }

  String? _mobileNumberValidator(String? number) {
    if (_mobileRegEx.hasMatch(number ?? '')) {
      return null;
    }

    return strings.enterValidMobileNumber;
  }

  String? _emailValidator(String? email) {
    if (_emailRegx.hasMatch(email ?? '')) {
      return null;
    }

    return strings.enterValidEmail;
  }

  RegExp get _mobileRegEx {
    return RegExp('(0/91)?[7-9][0-9]{9}');
  }

  RegExp get _emailRegx {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }
}
