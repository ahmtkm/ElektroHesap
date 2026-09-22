import 'data/cable_catalog.dart';
import 'models/calculation_models.dart';
import 'models/cable_data.dart';
import 'validation/calculation_validation.dart';

class CableCalculator {
  const CableCalculator._();

  static CableData? selectByAmpacity({
    required double currentA,
    required ConductorMaterial material,
  }) {
    CalculationValidation.positive('Akım', currentA);
    final catalog = material == ConductorMaterial.copper
        ? CableCatalog.copperAmpacity
        : CableCatalog.aluminumAmpacity;
    for (final cable in catalog) {
      if (cable.ampacityA != null && currentA <= cable.ampacityA!) {
        return cable;
      }
    }
    return null;
  }

  static CableData? selectByVoltageDrop({
    required double currentA,
    required double lengthM,
    required double voltageV,
    required Phase phase,
    required ConductorMaterial material,
    double maximumPercent = 3,
  }) {
    CalculationValidation.positive('Akım', currentA);
    CalculationValidation.positive('Mesafe', lengthM);
    CalculationValidation.positive('Gerilim', voltageV);
    CalculationValidation.positive('Maksimum gerilim düşümü', maximumPercent);
    final catalog = material == ConductorMaterial.copper
        ? CableCatalog.copperResistance
        : CableCatalog.aluminumResistance;
    for (final cable in catalog) {
      final percent = VoltageDropCalculator.percent(
        currentA: currentA,
        lengthM: lengthM,
        resistanceOhmPerKm: cable.resistanceOhmPerKm!,
        voltageV: voltageV,
        phase: phase,
      );
      if (percent <= maximumPercent) return cable;
    }
    return null;
  }
}

class VoltageDropCalculator {
  const VoltageDropCalculator._();

  static VoltageDropResult calculate({
    required CurrentResult currentResult,
    required double lengthM,
    required double resistanceOhmPerKm,
  }) {
    CalculationValidation.positive('Mesafe', lengthM);
    CalculationValidation.positive('Direnç', resistanceOhmPerKm);
    final voltageV = currentResult.inputs.voltageV;
    final phase = currentResult.inputs.phase;
    final multiplier = phase == Phase.three ? 1.7320508075688772 : 2.0;
    final voltageDropV =
        multiplier *
        currentResult.currentA *
        lengthM *
        resistanceOhmPerKm /
        1000;
    final percent = voltageDropV / voltageV * 100;
    return VoltageDropResult(
      voltageDropV: voltageDropV,
      percent: percent,
      currentResult: currentResult,
      lengthM: lengthM,
      resistanceOhmPerKm: resistanceOhmPerKm,
    );
  }

  static double percent({
    required double currentA,
    required double lengthM,
    required double resistanceOhmPerKm,
    required double voltageV,
    required Phase phase,
  }) {
    CalculationValidation.positive('Gerilim', voltageV);
    final result = calculate(
      currentResult: CurrentResult(
        currentA: currentA,
        inputs: CalculationInputs(
          powerKw: 1,
          voltageV: voltageV,
          phase: phase,
          cosPhi: 1,
        ),
      ),
      lengthM: lengthM,
      resistanceOhmPerKm: resistanceOhmPerKm,
    );
    return result.percent;
  }
}
