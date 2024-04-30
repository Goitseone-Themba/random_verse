import 'dart:math';
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

  startSimulation(int n, int N) {
    lengths = monteCarloSimulation(n, N);
    notifyListeners();
  }
}

//My Data model for the histogram
class MaxCycleLength {
  final double yValue;
  MaxCycleLength(this.yValue);
}

//Has an appbar and a column with 4 rows
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var lengthData = appState.lengths;
    int expectedMax = lengthData.reduce(max);

    final List<MaxCycleLength> chartData =
        lengthData.map((e) => MaxCycleLength(e.toDouble())).toList();

    final arraySizeController = TextEditingController();
    final permController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 360,
                    child: TextField(
                      controller: arraySizeController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter array size',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            arraySizeController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 360,
                    child: TextField(
                      controller: permController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter number of permutations:',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            permController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        appState.startSimulation(int.parse(arraySizeController.text), int.parse(permController.text));
                      },
                      icon: Icon(
                        Icons.directions_run_outlined,
                        size: 24,
                      ),
                      label: Text('Generate')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Distribution of Maximum Cycle Length",
                      style: TextStyle(fontSize: 24)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 720,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(
                                  -12,
                                  12,
                                ),
                              )
                            ],
                          ),
                          child: SizedBox(
                            height: 480,
                            width: 720,
                            child: chartData.isNotEmpty
                                ? SfCartesianChart(
                                    series: <CartesianSeries>[
                                      HistogramSeries<MaxCycleLength, num>(
                                        dataSource: chartData,
                                        yValueMapper:
                                            (MaxCycleLength cycleLength, _) =>
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
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Expected Maximum Cycle Length: $expectedMax'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
