import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/shared/utils/service_locator.dart';
import '../utils/logger.dart';
import '../utils/result.dart';

abstract class LocalStorage<T extends Object> {
  LocalStorage(this._logger);

  final Logger _logger;

  // ignore: lines_longer_than_80_chars
  /// Unique key for each object in the storage (UserSession-11ffb..., Notification-11ffb... e.g.).
  final String _uniqueItemKey = '${T.toString()}-11ffbf9b510648da';

  var _isInitialized = false;

  /// Gets a single item in [T] type by [key] from the storage.
  @protected
  Future<T?> getSingle(String key) async {
    final box = await _getBox();
    final value = await box.get(key);
    // Return the value directly if it's null or primitive.
    if (value == null || _isTypePrimitive()) return value;
    // Deserialize the object's value and return it.
    final jsonMap = json.decode(value);
    return locator<T>(param1: jsonMap);
  }

  /// Adds or updates a single [item] in [T] type by [key] in the storage.
  @protected
  Future<Result> putSingle(String key, T? item) async {
    try {
      final box = await _getBox();
      if (item == null || _isTypePrimitive()) {
        // Put the item into the box directly if it's null or primitive.
        await box.put(key, item);
      } else {
        // Serialize the item and add into the box as String.
        final jsonMap = (item as dynamic).toJson();
        final value = json.encode(jsonMap);
        await box.put(key, value);
      }
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
    return Result.success();
  }

  /// Removes a single item in [T] type by [key] from the storage.
  @protected
  Future<Result> removeSingle(String key) async {
    try {
      final box = await _getBox();
      await box.delete(key);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
    return Result.success();
  }

  /// Gets all the items in [T] type from the storage.
  @protected
  Future<Result<Iterable<T>, Failure>> getAll() async {
    final box = await _getBox();
    final items = <T>[];
    try {
      for (final key in box.keys) {
        final value = await box.get(key);
        if (value == null || _isTypePrimitive()) {
          // Add the value into the list directly if it's null or primitive.
          items.add(value);
        } else {
          // Deserialize the value and add into the list as object.
          final jsonMap = json.decode(value);
          final item = locator<T>(param1: jsonMap);
          items.add(item);
        }
      }
    } catch (e) {
      _logger.error('Fetching items from local storage failed: $e');
      return Result.failure(Failure(message: e.toString()));
    }
    _logger.debug('Items fetched from local storage: $items');
    return Result.success(value: items);
  }

  /// Gets the unique item representing [T] type from the storage.
  @protected
  Future<T?> getUniqueItem() {
    return getSingle(_uniqueItemKey);
  }

  /// Updates the unique [item] representing [T] type in the storage.
  @protected
  Future<void> updateUniqueItem(T? item) {
    return putSingle(_uniqueItemKey, item);
  }

  /// Removes the unique [item] representing [T] type from the storage.
  @protected
  Future<void> removeUniqueItem() {
    return removeSingle(_uniqueItemKey);
  }

  static Future<void> dispose() {
    return Hive.close();
  }

  // Helpers
  Future<void> _initialize() async {
    try {
      if (_isInitialized) return;
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      _isInitialized = true;
    } catch (_) {}
  }

  Future<LazyBox<dynamic>> _getBox() async {
    await _initialize();
    final boxName = T.toString();
    // Return the box if it's already open.
    if (Hive.isBoxOpen(boxName)) {
      return Hive.lazyBox(boxName);
    }
    // Open the box if it's not open yet.
    return Hive.openLazyBox(boxName);
  }

  bool _isTypePrimitive() =>
      T == int || T == double || T == bool || T == String;
  // - Helpers
}
