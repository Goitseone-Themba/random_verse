import 'dart:math';

int maxCycleLength(List<int> permutation) {
  final int n = permutation.length;
  final List<bool> visited = List<bool>.filled(n, false);
  int maxLength = 0;

  for (int i = 0; i < n; i++) {
    if (!visited[i]) {
      int cycleLength = 0;
      int currentNode = i;

      do {
        visited[currentNode] = true;
        currentNode = permutation[currentNode] - 1;
        cycleLength++;
      } while (!visited[currentNode]);

      maxLength = max(maxLength, cycleLength);
    }
  }

  return maxLength;
}
