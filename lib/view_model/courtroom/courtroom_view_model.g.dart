// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courtroom_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feature ViewModel managing the 7 dramatic trial sequence stages, auto-play timer,
/// and live verdict adjudication.

@ProviderFor(CourtroomViewModel)
final courtroomViewModelProvider = CourtroomViewModelProvider._();

/// Feature ViewModel managing the 7 dramatic trial sequence stages, auto-play timer,
/// and live verdict adjudication.
final class CourtroomViewModelProvider
    extends $NotifierProvider<CourtroomViewModel, CourtroomState?> {
  /// Feature ViewModel managing the 7 dramatic trial sequence stages, auto-play timer,
  /// and live verdict adjudication.
  CourtroomViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courtroomViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courtroomViewModelHash();

  @$internal
  @override
  CourtroomViewModel create() => CourtroomViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourtroomState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourtroomState?>(value),
    );
  }
}

String _$courtroomViewModelHash() =>
    r'98b5f8151c32bf97899a4257a7accf71b4031a14';

/// Feature ViewModel managing the 7 dramatic trial sequence stages, auto-play timer,
/// and live verdict adjudication.

abstract class _$CourtroomViewModel extends $Notifier<CourtroomState?> {
  CourtroomState? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CourtroomState?, CourtroomState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CourtroomState?, CourtroomState?>,
              CourtroomState?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
