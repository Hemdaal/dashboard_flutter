
import 'package:flutter/widgets.dart';

import 'fetch.dart';

extension SmartSnapShot<T> on AsyncSnapshot<Fetch<T>> {
  bool isLoading() {
    return this.data?.isLoading() == true;
  }

  bool isSuccess() {
    return this.data?.isSuccess() == true;
  }

  bool isError() {
    return this.data?.isError() == true;
  }

  T getContent() {
    return this.data!.content;
  }

  dynamic getError() {
    return this.data!.error;
  }

  dynamic getLoading() {
    return this.data!.fetching;
  }
}
