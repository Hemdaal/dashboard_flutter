import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

void main() {
  test('verify fetch creation based on snapshot', () {
    final errorSnapshot = AsyncSnapshot.withData(ConnectionState.none, Fetch.setError());
    expect(Fetch.fromSnapShot(errorSnapshot).isError(), true);

    final loadingSnapshot = AsyncSnapshot.withData(ConnectionState.none, Fetch.setFetching());
    expect(Fetch.fromSnapShot(loadingSnapshot).isLoading(), true);
    expect(Fetch.fromSnapShot(loadingSnapshot).isError(), false);
  });
}
