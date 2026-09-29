class Seek7Formatters {
  const Seek7Formatters._();

  static String euroFromCents(int cents) => '€${(cents / 100).toStringAsFixed(2)}';
}
