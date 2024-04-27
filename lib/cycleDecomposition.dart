
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

void testDecomposeCycles() {
  print('Testing decomposeCycles()...');

  // Test case 1
  final permutation1 = [2, 3, 4, 1, 5];
  final cycleLengths1 = decomposeCycles(permutation1);
  print('Test case 1 (permutation = [2, 3, 4, 1, 5]): ${cycleLengths1.toString() == [4, 1].toString() ? 'Passed' : 'Failed'}');

  // Test case 2
  final permutation2 = List.generate(1000, (i) => i % 1000 + 1);
  final cycleLengths2 = decomposeCycles(permutation2);
  print('Test case 2 (permutation of length 1000): ${cycleLengths2.length == 1 && cycleLengths2.first == 1000 ? 'Passed' : 'Failed'}');

  // Test case 3
  final permutation3 = [2, 3, 4, 5, 1];
  final cycleLengths3 = decomposeCycles(permutation3);
  print('Test case 3 (permutation = [2, 3, 4, 5, 1]): ${cycleLengths3 == [5] ? 'Passed' : 'Failed'}');

  // Test case 4
  final permutation4 = List.generate(10, (i) => i + 1);
  final cycleLengths4 = decomposeCycles(permutation4);
  print('Test case 4 (identity permutation of length 10): ${cycleLengths4.every((length) => length == 1) ? 'Passed' : 'Failed'}');

  // Test case 5
  final permutation5 = [1, 2, 3, 4, 4];
  try {
    decomposeCycles(permutation5);
    print('Test case 5 (invalid permutation = [1, 2, 3, 4, 4]): Failed');
  } catch (e) {
    print('Test case 5 (invalid permutation = [1, 2, 3, 4, 4]): Passed');
  }
}

void main() {
  
  testDecomposeCycles();
}