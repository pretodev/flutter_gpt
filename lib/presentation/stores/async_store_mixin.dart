import 'package:flutter/material.dart';

mixin AsyncStoreMixin on ChangeNotifier {
  bool _loading = false;

  bool get isLoading => _loading;

  void enableLoading() {
    _loading = true;
    notifyListeners();
  }

  void disableLoading() {
    _loading = false;
    notifyListeners();
  }

  Exception? _error;

  Exception? get error => _error;

  set error(Exception? error) {
    _error = error;
    notifyListeners();
  }
}
