// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ViewとModelを橋渡ししてくれるよ
final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin() async {}
}
