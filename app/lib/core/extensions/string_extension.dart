



extension StringExtension on String {
  String toCapitalize() {
    return length > 0 ? this[0].toUpperCase() + substring(1) : '';
  }
}