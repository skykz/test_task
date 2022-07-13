import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task/di/di_locator.dart';
import 'package:test_task/feature/presentation/ui/show_list_task_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Demo',
      theme: ThemeData(),
      home: const ShowTaskListScreen(),
    );
  }
}
