/// Marker interface and lifecycle contract for all domain services.
abstract interface class Service {
  /// Initializes any asynchronous resources or cached data.
  Future<void> init();

  /// Releases resources, timers, or stream subscriptions if required.
  void dispose();
}
