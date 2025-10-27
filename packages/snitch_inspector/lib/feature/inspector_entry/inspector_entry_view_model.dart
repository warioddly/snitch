import 'package:flutter/cupertino.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:snitch_inspector/shared/constants/storage_key.dart';
import 'package:snitch_inspector/shared/utils/local_storage.dart';

class InspectorEntryViewModel extends ViewModel {
  final _storage = LocalStorage.instance;
  final urlController = TextEditingController();
  bool isSaving = false;
  String? errorMessage;

  Future<void> save() async {
    if (urlController.text.isEmpty) {
      errorMessage = 'URL cannot be empty';
      notifyListeners();
      return;
    }
    errorMessage = null;
    isSaving = true;
    notifyListeners();
    if (!(await _checkConnectivity())) {
      errorMessage = 'Unable to connect to the provided URL';
      isSaving = false;
      notifyListeners();
      return;
    }
    await _storage.set(StorageKey.targetUrl, urlController.text);
    isSaving = false;
    notifyListeners();
  }

  Future<bool> _checkConnectivity() async {
    // Here you can implement actual connectivity check logic.
    // For demonstration, we will just simulate a delay.
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }
}
