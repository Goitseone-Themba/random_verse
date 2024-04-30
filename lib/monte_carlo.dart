import 'scrambled.dart';
import 'max_cycles.dart';

  ///@Author: Goitseone Themba 21000539
  List monteCarloSimulation(int n, int N) {
  // Implementation of monteCarloSimulation
  List<int> maxCycleLengths = [];
  int totalMaxCycleLength = 0;

  for (int i = 0; i < N; i++) {
    final List<int> permutation = scrambled(n);
    final int maxLength = maxCycleLength(permutation);
    maxCycleLengths.add(maxLength);
    totalMaxCycleLength += maxLength;
  }

  double expectedMax = totalMaxCycleLength/N;

  return [maxCycleLengths, expectedMax];
}