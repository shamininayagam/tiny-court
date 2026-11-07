import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/app_exception.dart';
import '../../model/app_settings.dart';
import '../../model/case.dart';
import '../../model/serializers.dart';
import '../../model/verdict.dart';

/// Key-Value partitioned storage adapter backed by SharedPreferences.
class AppStorage {
  final SharedPreferences _prefs;

  AppStorage(this._prefs);

  static const String keyIndexCaseIds = 'tc_index_case_ids';
  static const String keyCasePrefix = 'tc_case_';
  static const String keyVerdictPrefix = 'tc_verdict_';
  static const String keySettings = 'tc_settings';
  static const String keySeqCaseNumber = 'tc_seq_case_number';

  // ==================== CASE STORAGE ====================

  List<String> getCaseIds() {
    try {
      return _prefs.getStringList(keyIndexCaseIds) ?? <String>[];
    } catch (e) {
      throw StorageException('Failed to read case index', cause: e);
    }
  }

  Future<void> saveCase(Case c) async {
    try {
      final serialized = serializers.serializeWith(Case.serializer, c);
      final jsonStr = jsonEncode(serialized);
      await _prefs.setString('$keyCasePrefix${c.id}', jsonStr);

      final ids = getCaseIds();
      if (!ids.contains(c.id)) {
        // Prepend to maintain reverse-chronological order
        ids.insert(0, c.id);
        await _prefs.setStringList(keyIndexCaseIds, ids);
      }
    } catch (e) {
      throw StorageException('Failed to save case ${c.id}', cause: e);
    }
  }

  Case? getCase(String id) {
    try {
      final jsonStr = _prefs.getString('$keyCasePrefix$id');
      if (jsonStr == null) return null;
      final dynamic decoded = jsonDecode(jsonStr);
      return serializers.deserializeWith(Case.serializer, decoded);
    } catch (e) {
      throw StorageException('Failed to retrieve case $id', cause: e);
    }
  }

  Future<void> deleteCase(String id) async {
    try {
      await _prefs.remove('$keyCasePrefix$id');
      await _prefs.remove('$keyVerdictPrefix$id');
      final ids = getCaseIds();
      if (ids.remove(id)) {
        await _prefs.setStringList(keyIndexCaseIds, ids);
      }
    } catch (e) {
      throw StorageException('Failed to delete case $id', cause: e);
    }
  }

  // ==================== VERDICT STORAGE ====================

  Future<void> saveVerdict(Verdict v) async {
    try {
      final serialized = serializers.serializeWith(Verdict.serializer, v);
      final jsonStr = jsonEncode(serialized);
      await _prefs.setString('$keyVerdictPrefix${v.caseId}', jsonStr);
    } catch (e) {
      throw StorageException('Failed to save verdict for case ${v.caseId}', cause: e);
    }
  }

  Verdict? getVerdict(String caseId) {
    try {
      final jsonStr = _prefs.getString('$keyVerdictPrefix$caseId');
      if (jsonStr == null) return null;
      final dynamic decoded = jsonDecode(jsonStr);
      return serializers.deserializeWith(Verdict.serializer, decoded);
    } catch (e) {
      throw StorageException('Failed to retrieve verdict for case $caseId', cause: e);
    }
  }

  Future<void> deleteVerdict(String caseId) async {
    try {
      await _prefs.remove('$keyVerdictPrefix$caseId');
    } catch (e) {
      throw StorageException('Failed to delete verdict for case $caseId', cause: e);
    }
  }

  // ==================== SEQUENCE GENERATION ====================

  Future<int> getNextCaseNumberSequence() async {
    try {
      final current = _prefs.getInt(keySeqCaseNumber) ?? 0;
      final next = current + 1;
      await _prefs.setInt(keySeqCaseNumber, next);
      return next;
    } catch (e) {
      throw StorageException('Failed to generate case number sequence', cause: e);
    }
  }

  // ==================== SETTINGS STORAGE ====================

  AppSettings getSettings() {
    try {
      final jsonStr = _prefs.getString(keySettings);
      if (jsonStr == null) return AppSettings.defaults;
      final dynamic decoded = jsonDecode(jsonStr);
      return serializers.deserializeWith(AppSettings.serializer, decoded) ??
          AppSettings.defaults;
    } catch (e) {
      return AppSettings.defaults;
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    try {
      final serialized =
          serializers.serializeWith(AppSettings.serializer, settings);
      final jsonStr = jsonEncode(serialized);
      await _prefs.setString(keySettings, jsonStr);
    } catch (e) {
      throw StorageException('Failed to save app settings', cause: e);
    }
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
