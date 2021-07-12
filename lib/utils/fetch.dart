import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';

class Fetch<D> {
  dynamic? _fetchInfo;
  D? _content;
  dynamic? _error;
  _FetchState _state;

  Fetch(this._state);

  static Fetch<D> setFetching<D>([dynamic fetchInfo]) {
    final fetch = Fetch<D>(_FetchState.FETCHING);
    fetch._fetchInfo = fetchInfo;
    return fetch;
  }

  static Fetch<D> setError<D>([dynamic errorData]) {
    ConsoleLog.w('error', errorData);
    final fetch = Fetch<D>(_FetchState.ERROR);
    fetch._error = errorData;
    return fetch;
  }

  static Fetch<D> setContent<D>(D contentData) {
    final fetch = Fetch<D>(_FetchState.SUCCESS);
    fetch._content = contentData;
    return fetch;
  }

  static Fetch<D> fromSnapShot<D>(AsyncSnapshot<Fetch<D>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data ?? Fetch.setFetching();
    } else if (snapshot.hasError) {
      return Fetch.setError(snapshot.error);
    } else {
      return Fetch.setFetching();
    }
  }

  bool isSuccess() {
    return this._state == _FetchState.SUCCESS;
  }

  bool isError() {
    return this._state == _FetchState.ERROR;
  }

  bool isLoading() {
    return this._state == _FetchState.FETCHING;
  }

  get content => _content!;

  get fetchingInfo => _fetchInfo!;

  get error => _error!;
}

enum _FetchState { FETCHING, ERROR, SUCCESS }
