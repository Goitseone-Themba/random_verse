import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monte_carlo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:google_fonts/google_fonts.dart';

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
  List<int> lengths = [];

  startSimulation() {
    lengths = monteCarloSimulation(100, 10000);
    notifyListeners();
  }
}

class MaxCycleLength {
  final double yValue;
  MaxCycleLength(this.yValue);
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var lengthData = appState.lengths;

    final List<MaxCycleLength> chartData =
        lengthData.map((e) => MaxCycleLength(e.toDouble())).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Icon(
            Icons.language_rounded,
            color: Colors.black,
            size: 24,
          ),
          title: Text(
            'RandomVerse',
            // style: GoogleFonts.nunitoSans(),
          ),
          actions: [],
          elevation: 2,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Enter n : '),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    appState.startSimulation();
                  },
                  child: Text('Generate')),
              SizedBox(
                height: 128,
                child: Text('The length is $lengthData'),
              ),
              SizedBox(
                height: 480,
                width: 720,
                child: chartData.isNotEmpty
                    ? SfCartesianChart(
                        series: <CartesianSeries>[
                          HistogramSeries<MaxCycleLength, num>(
                            dataSource: chartData,
                            yValueMapper: (MaxCycleLength cycleLength, _) =>
                                cycleLength.yValue,
                            binInterval: 5,
                            showNormalDistributionCurve: true,
                            curveColor: Colors.deepOrange,
                            borderWidth: 3,
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ));
  }
}
