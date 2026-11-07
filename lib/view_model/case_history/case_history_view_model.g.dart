// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feature ViewModel managing case history loading, dynamic text search, and category/status filtering.

@ProviderFor(CaseHistoryViewModel)
final caseHistoryViewModelProvider = CaseHistoryViewModelProvider._();

/// Feature ViewModel managing case history loading, dynamic text search, and category/status filtering.
final class CaseHistoryViewModelProvider
    extends $NotifierProvider<CaseHistoryViewModel, CaseHistoryState> {
  /// Feature ViewModel managing case history loading, dynamic text search, and category/status filtering.
  CaseHistoryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'caseHistoryViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$caseHistoryViewModelHash();

  @$internal
  @override
  CaseHistoryViewModel create() => CaseHistoryViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CaseHistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaseHistoryState>(value),
    );
  }
}

String _$caseHistoryViewModelHash() =>
    r'fb1fe620a309dbe8daf72c438dd126b116fbf36f';

/// Feature ViewModel managing case history loading, dynamic text search, and category/status filtering.

abstract class _$CaseHistoryViewModel extends $Notifier<CaseHistoryState> {
  CaseHistoryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CaseHistoryState, CaseHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CaseHistoryState, CaseHistoryState>,
              CaseHistoryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
