import 'dart:async';

import 'package:final_frontend/screens/util/loading_view_event.dart';
import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  @protected
  LoadingViewEvent loadingViewEvent = LoadingViewEvent.idle;

  LoadingViewEvent get loadingEvent => loadingViewEvent;

  @protected
  Exception? error;

  Exception? get errorMessage => error;

  bool _canTouch = true;

  bool get canTouch => _canTouch;

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  @protected
  subscribe<T>(Future<T> request, Function(T response) onSuccess,
      {bool Function(Exception error)? customOnError,
      LoadingViewEvent loadingViewEvent = LoadingViewEvent.loading}) async {
    error = null;

    this.loadingViewEvent = loadingViewEvent;
    if (loadingViewEvent == LoadingViewEvent.loadingDisableTouch) {
      _canTouch = false;
    }

    if (_isDisposed) {
      return;
    }
    notifyListeners();

    try {
      T response = await request;

      if (_isDisposed) {
        return;
      }

      await onSuccess(response);
      setIdle();
    } on Exception catch (error) {
      if (_isDisposed) {
        return;
      }
      setIdle();

      if (customOnError != null) {
        bool isHandledError = customOnError(error);
        if (isHandledError) {
          notifyListeners();
          return;
        }
      }

      this.error = error;
      notifyListeners();
    }
  }

  @protected
  void setFullScreenLoading() {
    _canTouch = false;
    loadingViewEvent = LoadingViewEvent.loadingDisableTouch;
    notifyDataSetChange();
  }

  @protected
  void setLoading() {
    loadingViewEvent = LoadingViewEvent.loading;
    notifyDataSetChange();
  }

  @protected
  void setIdle() {
    _canTouch = true;
    loadingViewEvent = LoadingViewEvent.idle;
    notifyDataSetChange();
  }

  @protected
  void setLoadingWithoutProgress() {
    loadingViewEvent = LoadingViewEvent.notShowLoading;
    notifyDataSetChange();
  }

  bool isLoading() {
    return loadingViewEvent != LoadingViewEvent.idle;
  }

  @protected
  void notifyDataSetChange() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
