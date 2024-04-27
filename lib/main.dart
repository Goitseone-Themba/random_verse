import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monteCarlo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'globe',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<int> maximumLength = [];

  startSimulation() {
    maximumLength = monteCarloSimulation(10, 1000000);
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var length = appState.maximumLength;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter n :'),
          ElevatedButton(
              onPressed: () {
                appState.startSimulation();
              },
              child: Text('Generate')),
          SizedBox(height: 128, child: Text('The length is $length'),
          ),
        ],
      ),
    ));
  }
}
