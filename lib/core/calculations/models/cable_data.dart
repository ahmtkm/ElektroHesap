import 'calculation_models.dart';

class CableData {
  const CableData({
    required this.sectionMm2,
    required this.material,
    this.ampacityA,
    this.resistanceOhmPerKm,
    this.isUnverified = true,
  });

  final double sectionMm2;
  final ConductorMaterial material;
  final double? ampacityA;
  final double? resistanceOhmPerKm;
  final bool isUnverified;

  String get label =>
      '${sectionMm2.toStringAsFixed(sectionMm2 % 1 == 0 ? 0 : 2)} mm²';
}
