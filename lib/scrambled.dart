import 'dart:math';

///@Author: Goitseone Themba 21000539
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
