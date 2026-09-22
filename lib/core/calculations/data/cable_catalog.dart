import '../models/calculation_models.dart';
import '../models/cable_data.dart';

/// UNVERIFIED_DATA: Values retained from the original prototype.
/// They require source, temperature, installation method and standard review
/// before being presented as engineering-compliant data.
class CableCatalog {
  const CableCatalog._();

  static const copperAmpacity = <CableData>[
    CableData(
      sectionMm2: 2.5,
      material: ConductorMaterial.copper,
      ampacityA: 21,
    ),
    CableData(sectionMm2: 4, material: ConductorMaterial.copper, ampacityA: 28),
    CableData(sectionMm2: 6, material: ConductorMaterial.copper, ampacityA: 36),
    CableData(
      sectionMm2: 10,
      material: ConductorMaterial.copper,
      ampacityA: 50,
    ),
    CableData(
      sectionMm2: 16,
      material: ConductorMaterial.copper,
      ampacityA: 68,
    ),
    CableData(
      sectionMm2: 25,
      material: ConductorMaterial.copper,
      ampacityA: 89,
    ),
    CableData(
      sectionMm2: 35,
      material: ConductorMaterial.copper,
      ampacityA: 110,
    ),
    CableData(
      sectionMm2: 50,
      material: ConductorMaterial.copper,
      ampacityA: 140,
    ),
    CableData(
      sectionMm2: 70,
      material: ConductorMaterial.copper,
      ampacityA: 180,
    ),
    CableData(
      sectionMm2: 95,
      material: ConductorMaterial.copper,
      ampacityA: 220,
    ),
    CableData(
      sectionMm2: 120,
      material: ConductorMaterial.copper,
      ampacityA: 260,
    ),
    CableData(
      sectionMm2: 150,
      material: ConductorMaterial.copper,
      ampacityA: 300,
    ),
    CableData(
      sectionMm2: 185,
      material: ConductorMaterial.copper,
      ampacityA: 340,
    ),
    CableData(
      sectionMm2: 240,
      material: ConductorMaterial.copper,
      ampacityA: 400,
    ),
    CableData(
      sectionMm2: 300,
      material: ConductorMaterial.copper,
      ampacityA: 460,
    ),
    CableData(
      sectionMm2: 400,
      material: ConductorMaterial.copper,
      ampacityA: 520,
    ),
  ];

  static const aluminumAmpacity = <CableData>[];

  static const copperResistance = <CableData>[
    CableData(
      sectionMm2: 2.5,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 7.41,
    ),
    CableData(
      sectionMm2: 4,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 4.61,
    ),
    CableData(
      sectionMm2: 6,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 3.08,
    ),
    CableData(
      sectionMm2: 10,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 1.83,
    ),
    CableData(
      sectionMm2: 16,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 1.15,
    ),
    CableData(
      sectionMm2: 25,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.727,
    ),
    CableData(
      sectionMm2: 35,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.524,
    ),
    CableData(
      sectionMm2: 50,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.387,
    ),
    CableData(
      sectionMm2: 70,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.268,
    ),
    CableData(
      sectionMm2: 95,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.193,
    ),
    CableData(
      sectionMm2: 120,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.153,
    ),
    CableData(
      sectionMm2: 150,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.124,
    ),
    CableData(
      sectionMm2: 185,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.0991,
    ),
    CableData(
      sectionMm2: 240,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.0754,
    ),
    CableData(
      sectionMm2: 300,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.0601,
    ),
    CableData(
      sectionMm2: 400,
      material: ConductorMaterial.copper,
      resistanceOhmPerKm: 0.047,
    ),
  ];

  static const aluminumResistance = <CableData>[
    CableData(
      sectionMm2: 16,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 1.91,
    ),
    CableData(
      sectionMm2: 25,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 1.20,
    ),
    CableData(
      sectionMm2: 35,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.868,
    ),
    CableData(
      sectionMm2: 50,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.641,
    ),
    CableData(
      sectionMm2: 70,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.443,
    ),
    CableData(
      sectionMm2: 95,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.320,
    ),
    CableData(
      sectionMm2: 120,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.253,
    ),
    CableData(
      sectionMm2: 150,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.206,
    ),
    CableData(
      sectionMm2: 185,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.164,
    ),
    CableData(
      sectionMm2: 240,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.125,
    ),
    CableData(
      sectionMm2: 300,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.100,
    ),
    CableData(
      sectionMm2: 400,
      material: ConductorMaterial.aluminum,
      resistanceOhmPerKm: 0.0778,
    ),
  ];
}
