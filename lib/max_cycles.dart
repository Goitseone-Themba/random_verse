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

void testMaxCycleLength() {
  print('\nTesting maxCycleLength()...');

  // Test case 1
  final permutation1 = [2, 3, 4, 1, 5];
  final maxLength1 = maxCycleLength(permutation1);
  print('Test case 1 (permutation = [2, 3, 4, 1, 5]): ${maxLength1 == 4 ? 'Passed' : 'Failed'}');

  // Test case 2
  final permutation2 = List.generate(1000, (i) => i % 1000 + 1);
  final maxLength2 = maxCycleLength(permutation2);
  print('Test case 2 (permutation of length 1000): ${maxLength2 == 1000 ? 'Passed' : 'Failed'}');

  // Test case 3
  final permutation3 = [2, 3, 4, 5, 1];
  final maxLength3 = maxCycleLength(permutation3);
  print('Test case 3 (permutation = [2, 3, 4, 5, 1]): ${maxLength3 == 5 ? 'Passed' : 'Failed'}');

  // Test case 4
  final permutation4 = List.generate(10, (i) => i + 1);
  final maxLength4 = maxCycleLength(permutation4);
  print('Test case 4 (identity permutation of length 10): ${maxLength4 == 1 ? 'Passed' : 'Failed'}');

  // Test case 5
  final permutation5 = [1, 2, 3, 4, 4];
  try {
    maxCycleLength(permutation5);
    print('Test case 5 (invalid permutation = [1, 2, 3, 4, 4]): Failed');
  } catch (e) {
    print('Test case 5 (invalid permutation = [1, 2, 3, 4, 4]): Passed');
  }
}

void main() {
  testMaxCycleLength();
}