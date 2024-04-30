import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monte_carlo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

///@Author: Goitseone Themba 21000539
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

//Keeps track of the list of lengths and the expected maximum length
class MyAppState extends ChangeNotifier {
  List<int> lengths = [];
  double expectedMax = 0;

  startSimulation(int n, int N) {
    List data = monteCarloSimulation(n, N);
    lengths = data[0];
    expectedMax = data[1];

    notifyListeners();
  }
}

//My Data model for the histogram
class MaxCycleLength {
  final double yValue;
  MaxCycleLength(this.yValue);
}

//Has an appbar and a column with 3 rows
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var lengthData = appState.lengths;
    double expectedMax = appState.expectedMax;

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
          ),
          actions: [],
          elevation: 2,
        ),
        body: Center(
          //First Row contains the form
          child: Padding(
            padding: EdgeInsets.fromLTRB(256, 64, 256, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            if (arraySizeController.text.isNotEmpty &&
                                permController.text.isNotEmpty) {
                              appState.startSimulation(
                                  int.parse(arraySizeController.text),
                                  int.parse(permController.text));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('close'),
                                    ),
                                  ],
                                  title: const Text(
                                      'Invalid input, array size and number of permutations cannot be empty...'),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.directions_run_outlined,
                            size: 24,
                          ),
                          label: Text('Generate')),
                    ],
                  ),
                ),

                //Second Row contains the Title of the histogram
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Distribution of Maximum Cycle Length",
                        style: TextStyle(fontSize: 24)),
                  ],
                ),

                //Third row contains a the histogram and expected Max cycle length
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Row(
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
                                                (MaxCycleLength cycleLength,
                                                        _) =>
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'Expected Maximum Cycle Length: $expectedMax'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
