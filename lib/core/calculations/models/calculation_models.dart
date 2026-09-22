enum Phase { single, three }

enum ConductorMaterial { copper, aluminum }

class CalculationInputs {
  const CalculationInputs({
    required this.powerKw,
    required this.voltageV,
    required this.phase,
    required this.cosPhi,
    this.efficiency = 1.0,
  });

  final double powerKw;
  final double voltageV;
  final Phase phase;
  final double cosPhi;
  final double efficiency;
}

class CurrentResult {
  const CurrentResult({required this.currentA, required this.inputs});

  final double currentA;
  final CalculationInputs inputs;
}

class VoltageDropResult {
  const VoltageDropResult({
    required this.voltageDropV,
    required this.percent,
    required this.currentResult,
    required this.lengthM,
    required this.resistanceOhmPerKm,
  });

  final double voltageDropV;
  final double percent;
  final CurrentResult currentResult;
  final double lengthM;
  final double resistanceOhmPerKm;
}

class FuseSelectionResult {
  const FuseSelectionResult({
    required this.loadCurrentA,
    required this.nominalCurrentA,
    required this.isWithinCatalog,
    required this.preliminary,
    required this.note,
  });

  final double loadCurrentA;
  final int? nominalCurrentA;
  final bool isWithinCatalog;
  final bool preliminary;
  final String note;
}
