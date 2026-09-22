import 'models/calculation_models.dart';
import 'validation/calculation_validation.dart';

class CurrentCalculator {
  const CurrentCalculator._();

  static CurrentResult calculate(CalculationInputs inputs) {
    CalculationValidation.positive('Güç', inputs.powerKw);
    CalculationValidation.positive('Gerilim', inputs.voltageV);
    CalculationValidation.unitInterval('cosφ', inputs.cosPhi);
    CalculationValidation.unitInterval('Verim', inputs.efficiency);

    const sqrt3 = 1.7320508075688772;
    final phaseFactor = inputs.phase == Phase.three ? sqrt3 : 1.0;
    final current =
        (inputs.powerKw * 1000) /
        (phaseFactor * inputs.voltageV * inputs.cosPhi * inputs.efficiency);

    if (!current.isFinite || current <= 0) {
      throw ArgumentError('Akım sonucu geçerli değil.');
    }

    return CurrentResult(currentA: current, inputs: inputs);
  }
}
