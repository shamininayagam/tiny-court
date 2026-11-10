// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_draft_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feature ViewModel managing the multi-step case creation wizard, validation, and draft submission.

@ProviderFor(CaseDraftViewModel)
final caseDraftViewModelProvider = CaseDraftViewModelProvider._();

/// Feature ViewModel managing the multi-step case creation wizard, validation, and draft submission.
final class CaseDraftViewModelProvider
    extends $NotifierProvider<CaseDraftViewModel, CaseDraftState> {
  /// Feature ViewModel managing the multi-step case creation wizard, validation, and draft submission.
  CaseDraftViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'caseDraftViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$caseDraftViewModelHash();

  @$internal
  @override
  CaseDraftViewModel create() => CaseDraftViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CaseDraftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaseDraftState>(value),
    );
  }
}

String _$caseDraftViewModelHash() =>
    r'a11d893baa635532d3ed2d381c3f34e63518bdcd';

/// Feature ViewModel managing the multi-step case creation wizard, validation, and draft submission.

abstract class _$CaseDraftViewModel extends $Notifier<CaseDraftState> {
  CaseDraftState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CaseDraftState, CaseDraftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CaseDraftState, CaseDraftState>,
              CaseDraftState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
