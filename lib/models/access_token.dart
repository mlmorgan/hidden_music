import 'package:flutter/foundation.dart';

class AccessToken {
  final String value;
  final DateTime expiresAt;

  AccessToken({
    @required this.value,
    @required this.expiresAt,
  });
}
