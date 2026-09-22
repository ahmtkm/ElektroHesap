class CalculationValidation {
  static void positive(String name, double value) {
    if (!value.isFinite || value <= 0) {
      throw ArgumentError('$name sıfırdan büyük ve geçerli olmalıdır.');
    }
  }

  static void unitInterval(String name, double value) {
    if (!value.isFinite || value <= 0 || value > 1) {
      throw ArgumentError('$name 0 ile 1 arasında olmalıdır.');
    }
  }
}
