import '../../ui.dart';
import 'app_theme.dart';

extension _MaterialStateUtils on Set<WidgetState> {
  Set<WidgetState> get activeStates => <WidgetState>{
        WidgetState.pressed,
        WidgetState.selected,
      };

  bool get hasActiveStates {
    return intersection(activeStates).isNotEmpty;
  }

  bool get hasHovered => contains(WidgetState.hovered);
}

class AppButtonChild extends StatelessWidget {
  const AppButtonChild(
    this.text, {
    super.key,
    this.prefixIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.suffixIcon,
  });

  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        if (prefixIcon != null) ...<Widget>[
          IconTheme(
            data: IconTheme.of(context).copyWith(size: 18),
            child: prefixIcon!,
          ),
          const SizedBox(width: 8),
        ],
        Text(text),
        if (suffixIcon != null) ...<Widget>[
          const SizedBox(width: 12),
          IconTheme(
            data: IconTheme.of(context).copyWith(size: 18),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }
}

/// Defines the base of the AppButton
abstract class _AppButton extends StatelessWidget {
  const _AppButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  final AppButtonChild child;
  final VoidCallback? onPressed;

  AppButtonTheme getAppButtonTheme(BuildContext context) {
    return context.appTheme.primaryButtonTheme;
  }

  OutlinedBorder? resolveButtonShape(
      BuildContext context, Set<WidgetState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  Color resolveOverlayColor(BuildContext context, Set<WidgetState> states) {
    return Colors.black12;
  }

  Color resolveBackgroundColor(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    final AppButtonTheme appButtonTheme = getAppButtonTheme(context);
    Color? color;
    if (states.hasActiveStates) {
      color = appButtonTheme.activeColor;
    }
    if (states.hasHovered) {
      color = appButtonTheme.hoverColor;
    }

    color ??= appButtonTheme.defaultColor;
    return color;
  }

  Color resolveForegroundColor(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    final AppButtonTheme appButtonTheme = getAppButtonTheme(context);
    Color? color;
    if (states.hasActiveStates) {
      color = appButtonTheme.activeTextColor;
    }
    if (states.hasHovered) {
      color = appButtonTheme.hoverTextColor;
    }

    color ??= appButtonTheme.defaultTextColor;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: getButtonStyle(context),
      child: child,
    );
  }

  ButtonStyle getButtonStyle(BuildContext context) {
    return ButtonStyle(
      splashFactory: Theme.of(context).splashFactory,
      animationDuration: Duration.zero,
      shape: WidgetStateProperty.resolveWith(
        (Set<WidgetState> s) => resolveButtonShape(context, s),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 18,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) => resolveForegroundColor(context, s)),
      overlayColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) => resolveOverlayColor(context, s)),
      backgroundColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> s) => resolveBackgroundColor(context, s),
      ),
    );
  }
}

class AppButton extends _AppButton {
  const AppButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.primaryButtonTheme;
}

class AppPrimaryButton extends _AppButton {
  const AppPrimaryButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.primaryButtonTheme;
}

class AppSecondaryButton extends _AppButton {
  const AppSecondaryButton({
    super.key,
    super.onPressed,
    required super.child,
  });

  @override
  AppButtonTheme getAppButtonTheme(BuildContext context) =>
      context.appTheme.secondaryButtonTheme;
}
