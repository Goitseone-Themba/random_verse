import 'dart:math';

List<int> scrambled(int n) {
  final List<int> nums = List<int>.generate(n, (i) => i + 1);

  final Random random = Random();

  for (int i = 0; i < n; i++) {
    final int j = i + random.nextInt(n - i);
    final int temp = nums[i];
    nums[i] = nums[j];
    nums[j] = temp;
  }

  return nums;
}

void testScrambled() {
  print('Testing scrambled()...');

  // Test case 1
  final permutation1 = scrambled(5);
  final isValid1 = _isValidPermutation(permutation1, 5);
  print('Test case 1 (n = 5): ${isValid1 ? 'Passed' : 'Failed'}');

  // Test case 2
  final permutation2 = scrambled(1000);
  final isValid2 = _isValidPermutation(permutation2, 1000);
  print('Test case 2 (n = 1000): ${isValid2 ? 'Passed' : 'Failed'}');

  // Add more test cases as needed
}

bool _isValidPermutation(List<int> permutation, int n) {
  if (permutation.length != n) return false;
  final Set<int> uniqueElements = permutation.toSet();
  if (uniqueElements.length != n) return false;
  if (!uniqueElements.containsAll(List.generate(n, (i) => i + 1))) return false;
  return true;
}

void main() {

  testScrambled();

}

