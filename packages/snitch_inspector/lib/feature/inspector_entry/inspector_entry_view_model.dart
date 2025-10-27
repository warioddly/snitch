import 'package:flutter/cupertino.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:snitch_inspector/shared/constants/storage_key.dart';
import 'package:snitch_inspector/shared/utils/local_storage.dart';

class InspectorEntryViewModel extends ViewModel {
  final _storage = LocalStorage.instance;
  final urlController = TextEditingController();
  bool isSaving = false;

  Future<void> save() async {
    if (urlController.text.isEmpty) {
      return;
    }
    isSaving = true;
    notifyListeners();
    // _checkConnectivity();
    await _storage.set(StorageKey.targetUrl, urlController.text);
    isSaving = false;
    notifyListeners();
  }

  // void _checkConnectivity() {
  //   throw UnimplementedError();
  // }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }
}
