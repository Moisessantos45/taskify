import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:provider/provider.dart';
import 'package:taskify/presentation/provider/provider_bd.dart';
import 'package:taskify/presentation/provider/provider_task.dart';
import 'package:taskify/presentation/screen/home.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProviderTask()),
      ChangeNotifierProvider(create: (_) => ProviderBd()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        builder: InAppNotifications.init());
  }
}
