String? nonEmptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a name';
  }
  return null;
}
