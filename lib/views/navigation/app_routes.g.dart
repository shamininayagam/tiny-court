// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homePageRoute];

RouteBase get $homePageRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $HomePageRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'profile/:id',
      hasOverriddenOnExit: false,
      factory: $ProfilePageRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'terms',
      hasOverriddenOnExit: false,
      factory: $TermsPageRoute._fromState,
    ),
  ],
);

mixin $HomePageRoute on GoRouteData {
  static HomePageRoute _fromState(GoRouterState state) => HomePageRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfilePageRoute on GoRouteData {
  static ProfilePageRoute _fromState(GoRouterState state) =>
      ProfilePageRoute(id: int.parse(state.pathParameters['id']!));

  ProfilePageRoute get _self => this as ProfilePageRoute;

  @override
  String get location => GoRouteData.$location(
    '/profile/${Uri.encodeComponent(_self.id.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TermsPageRoute on GoRouteData {
  static TermsPageRoute _fromState(GoRouterState state) => TermsPageRoute();

  @override
  String get location => GoRouteData.$location('/terms');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
