import 'package:flutter/material.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/youpass_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const YouPassApp());
}
