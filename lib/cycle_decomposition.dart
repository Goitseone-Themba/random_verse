
///@Author: Goitseone Themba 21000539
List<int> decomposeCycles(List<int> permutation) {
  final int n = permutation.length;
  final List<bool> visited = List<bool>.filled(n, false);
  final List<int> cycleLengths = [];

  for (int i = 0; i < n; i++) {
    if (!visited[i]) {
      int cycleLength = 0;
      int currentNode = i;

      do {
        visited[currentNode] = true;
        currentNode = permutation[currentNode] - 1;
        cycleLength++;
      } while (!visited[currentNode]);

      cycleLengths.add(cycleLength);
    }
  }

  return cycleLengths;
}

