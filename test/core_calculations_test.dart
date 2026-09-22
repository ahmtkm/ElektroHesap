import 'package:elektro_hesap/core/calculations/cable_calculator.dart';
import 'package:elektro_hesap/core/calculations/current_calculator.dart';
import 'package:elektro_hesap/core/calculations/fuse_calculator.dart';
import 'package:elektro_hesap/core/calculations/models/calculation_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrentCalculator', () {
    test('230 V single phase calculates current', () {
      final result = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 2.3,
          voltageV: 230,
          phase: Phase.single,
          cosPhi: 1,
        ),
      );
      expect(result.currentA, closeTo(10, 0.0001));
    });

    test('400 V three phase calculates current', () {
      final result = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 6.9282032303,
          voltageV: 400,
          phase: Phase.three,
          cosPhi: 1,
        ),
      );
      expect(result.currentA, closeTo(10, 0.0001));
    });

    test('efficiency below one increases current', () {
      final fullEfficiency = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 2.3,
          voltageV: 230,
          phase: Phase.single,
          cosPhi: 1,
        ),
      );
      final reducedEfficiency = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 2.3,
          voltageV: 230,
          phase: Phase.single,
          cosPhi: 1,
          efficiency: 0.8,
        ),
      );
      expect(
        reducedEfficiency.currentA,
        closeTo(fullEfficiency.currentA / 0.8, 0.0001),
      );
    });

    test('rejects invalid power, voltage and cos phi', () {
      expect(
        () => CurrentCalculator.calculate(
          const CalculationInputs(
            powerKw: 1,
            voltageV: 0,
            phase: Phase.single,
            cosPhi: 1,
          ),
        ),
        throwsArgumentError,
      );
      expect(
        () => CurrentCalculator.calculate(
          const CalculationInputs(
            powerKw: 1,
            voltageV: 230,
            phase: Phase.single,
            cosPhi: 1.1,
          ),
        ),
        throwsArgumentError,
      );
      expect(
        () => CurrentCalculator.calculate(
          const CalculationInputs(
            powerKw: 0,
            voltageV: 230,
            phase: Phase.single,
            cosPhi: 1,
          ),
        ),
        throwsArgumentError,
      );
    });
  });

  group('VoltageDropCalculator', () {
    test('calculates single phase voltage drop', () {
      final current = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 2.3,
          voltageV: 230,
          phase: Phase.single,
          cosPhi: 1,
        ),
      );
      final result = VoltageDropCalculator.calculate(
        currentResult: current,
        lengthM: 10,
        resistanceOhmPerKm: 7.41,
      );
      expect(result.voltageDropV, closeTo(1.482, 0.001));
      expect(result.percent, closeTo(0.6443, 0.001));
    });

    test('calculates three phase voltage drop', () {
      final current = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 6.9282032303,
          voltageV: 400,
          phase: Phase.three,
          cosPhi: 1,
        ),
      );
      final result = VoltageDropCalculator.calculate(
        currentResult: current,
        lengthM: 10,
        resistanceOhmPerKm: 3.08,
      );
      expect(result.voltageDropV, closeTo(0.5335, 0.001));
    });

    test('rejects invalid length and section data', () {
      final current = CurrentCalculator.calculate(
        const CalculationInputs(
          powerKw: 1,
          voltageV: 230,
          phase: Phase.single,
          cosPhi: 1,
        ),
      );
      expect(
        () => VoltageDropCalculator.calculate(
          currentResult: current,
          lengthM: 0,
          resistanceOhmPerKm: 1,
        ),
        throwsArgumentError,
      );
      expect(
        () => VoltageDropCalculator.calculate(
          currentResult: current,
          lengthM: 10,
          resistanceOhmPerKm: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('FuseCalculator', () {
    test('selects first nominal value not below load current', () {
      final result = FuseCalculator.select(17);
      expect(result.nominalCurrentA, 20);
      expect(result.preliminary, isTrue);
    });

    test('does not fabricate a result above catalog maximum', () {
      final result = FuseCalculator.select(401);
      expect(result.nominalCurrentA, isNull);
      expect(result.isWithinCatalog, isFalse);
    });
  });
}
