import '../../ui.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this._style,
  });

  final String text;
  final TextStyle? _style;

  TextStyle? getStyle(BuildContext context) {
    return _style;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle(context),
    );
  }
}

class DisplayLarge extends AppText {
  const DisplayLarge(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.displayLarge;
  }
}

class DisplayMedium extends AppText {
  const DisplayMedium(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.displayMedium;
  }
}

class DisplaySmall extends AppText {
  const DisplaySmall(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.displaySmall;
  }
}

class HeadLineLarge extends AppText {
  const HeadLineLarge(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.headlineLarge;
  }
}

class HeadLineMedium extends AppText {
  const HeadLineMedium(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.headlineMedium;
  }
}

class HeadLineSmall extends AppText {
  const HeadLineSmall(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.headlineSmall;
  }
}

class TitleLarge extends AppText {
  const TitleLarge(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.titleLarge;
  }
}

class TitleMedium extends AppText {
  const TitleMedium(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.titleMedium;
  }
}

class TitleSmall extends AppText {
  const TitleSmall(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.titleSmall;
  }
}

class BodyLarge extends AppText {
  const BodyLarge(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.bodyLarge;
  }
}

class BodyMedium extends AppText {
  const BodyMedium(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.bodyMedium;
  }
}

class BodySmall extends AppText {
  const BodySmall(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.bodySmall;
  }
}

class LabelLarge extends AppText {
  const LabelLarge(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.labelLarge;
  }
}

class LabelMedium extends AppText {
  const LabelMedium(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.labelMedium;
  }
}

class LabelSmall extends AppText {
  const LabelSmall(super.text, {super.key});

  @override
  TextStyle? getStyle(BuildContext context) {
    return context.textTheme.labelSmall;
  }
}
