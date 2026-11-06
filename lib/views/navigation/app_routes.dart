import 'dart:async';

import 'package:go_router/go_router.dart';

import '../../ui.dart' hide RouterUtils;
import '../home_page.dart';
import '../profile_page.dart';
import '../terms_page.dart';

part 'app_routes.g.dart';

RouterConfig<Object> appRouter() {
  return GoRouter(
    routes: $appRoutes,
    redirect: (BuildContext c, GoRouterState s) {
      return null;
    },
    debugLogDiagnostics: true,
  );
}

extension RouteUtil on String {
  String withFrom(String? redirect) {
    final String r = redirect != null ? '?from=$redirect' : '';
    return '$this$r';
  }
}

abstract class AppRouterData extends GoRouteData {
  const AppRouterData();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (this is UnauthenticatedRouteData) {
      return null;
    }
    if (this is AuthenticatedRouteData) {
      if (context.appViewModel.getState().count == null) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildWidget(context, state);
  }

  Widget buildWidget(BuildContext context, GoRouterState state) {
    throw UnimplementedError('Implement buildWidget');
  }
}

mixin DesktopContainerMixin on AppRouterData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildWidget(context, state);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // if(context.isDesktop) return DesktopContainer();
    return super.buildPage(context, state);
  }
}

abstract class AuthenticatedRouteData extends AppRouterData {
  const AuthenticatedRouteData();
}

abstract class UnauthenticatedRouteData extends AppRouterData {
  const UnauthenticatedRouteData();
}

/// Home Page
@TypedGoRoute<HomePageRoute>(
  path: '/',
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ProfilePageRoute>(
      path: 'profile/:id',
    ),
    TypedGoRoute<TermsPageRoute>(
      path: 'terms',
    ),
  ],
)
@immutable
class HomePageRoute extends AuthenticatedRouteData {
  @override
  Widget buildWidget(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@immutable
class ProfilePageRoute extends AuthenticatedRouteData {
  const ProfilePageRoute({
    required this.id,
  });

  final int id;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

@immutable
class TermsPageRoute extends UnauthenticatedRouteData {
  @override
  Widget buildWidget(BuildContext context, GoRouterState state) {
    return const TermsPage();
  }
}
