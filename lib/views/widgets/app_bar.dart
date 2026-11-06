import '../../ui.dart';

class ApplicationAppBar extends AppBar {
  ApplicationAppBar({
    super.key,
    super.leading,
    super.automaticallyImplyLeading = true,
    super.title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation = 0.0,
    super.shape,
    Color? backgroundColor,
    super.systemOverlayStyle,
    super.iconTheme,
    super.actionsIconTheme,
    super.toolbarTextStyle,
    super.primary = true,
    super.centerTitle,
    super.titleSpacing = NavigationToolbar.kMiddleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.toolbarHeight,
  }) : super(
          backgroundColor: backgroundColor ?? Colors.transparent,
        );
}
