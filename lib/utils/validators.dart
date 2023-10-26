String? categoryNameValidator(String? value) {
  if (value == null) return 'Please enter a value';
  final cleanValue = value.trim();
  if (cleanValue.isEmpty) return 'Please enter a value';
  return null;
}
