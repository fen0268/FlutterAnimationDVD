import 'package:flutter/material.dart';

Offset vectors(int num) {
  if (num == 0) {
    return const Offset(4, -4);
  } else if (num == 1) {
    return const Offset(-4, -4);
  } else if (num == 2) {
    return const Offset(-4, 4);
  } else if (num == 3) {
    return const Offset(4, 4);
  } else {
    return const Offset(0, 0);
  }
}
