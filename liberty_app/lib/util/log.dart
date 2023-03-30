import 'package:flutter/foundation.dart';

void printOnDebug(message) {
  if (kDebugMode) {
    print("_onNameChanged " + message.toString());
  }
}
