extension StringExtension on String? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;
}
