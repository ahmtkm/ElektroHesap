import 'models/calculation_models.dart';
import 'validation/calculation_validation.dart';

class FuseCalculator {
  const FuseCalculator._();

  static const nominalCurrents = <int>[
    6,
    10,
    16,
    20,
    25,
    32,
    40,
    50,
    63,
    80,
    100,
    125,
    160,
    200,
    250,
    315,
    400,
  ];

  static FuseSelectionResult select(double loadCurrentA) {
    CalculationValidation.positive('Yük akımı', loadCurrentA);
    final nominal = nominalCurrents.cast<int?>().firstWhere(
      (value) => value! >= loadCurrentA,
      orElse: () => null,
    );
    return FuseSelectionResult(
      loadCurrentA: loadCurrentA,
      nominalCurrentA: nominal,
      isWithinCatalog: nominal != null,
      preliminary: true,
      note: nominal == null
          ? 'Akım katalogdaki nominal değerlerin üzerinde; sonuç üretilmedi.'
          : 'Bu yalnızca yük akımına göre ön nominal seçimdir. Kablo, açma eğrisi ve kesme kapasitesi ayrıca doğrulanmalıdır.',
    );
  }
}
