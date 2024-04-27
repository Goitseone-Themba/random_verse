import 'scrambled.dart';
import 'maxCycles.dart';

List<int> monteCarloSimulation(int n, int N) {
  // Implementation of monteCarloSimulation
  List<int> maxCycleLengths = [];

  for (int i = 0; i < N; i++) {
    final List<int> permutation = scrambled(n);
    final int maxLength = maxCycleLength(permutation);
    maxCycleLengths.add(maxLength);
  }

  return maxCycleLengths;
}