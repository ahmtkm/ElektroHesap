import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';
import '../core/calculations/cable_calculator.dart';
import '../core/calculations/current_calculator.dart';
import '../core/calculations/data/cable_catalog.dart';
import '../core/calculations/models/calculation_models.dart';
import '../core/calculations/models/cable_data.dart';

class VoltageDropPage extends StatefulWidget {
  const VoltageDropPage({super.key});

  @override
  State<VoltageDropPage> createState() => _VoltageDropPageState();
}

class _VoltageDropPageState extends State<VoltageDropPage> {
  final TextEditingController powerController = TextEditingController();
  final TextEditingController voltageController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  String phase = "3";
  String material = "Cu";
  double cosphi = 0.8;
  double selectedResistance = 3.08;

  double? resultPercent;
  String recommendedCable = "";
  final formKey = GlobalKey<FormState>();

  List<CableData> get currentCables => material == "Cu"
      ? CableCatalog.copperResistance
      : CableCatalog.aluminumResistance;

  @override
  void dispose() {
    powerController.dispose();
    voltageController.dispose();
    distanceController.dispose();
    super.dispose();
  }

  void calculate() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final power = double.parse(powerController.text);
    final voltage = double.parse(voltageController.text);
    final distance = double.parse(distanceController.text);
    final currentResult = CurrentCalculator.calculate(
      CalculationInputs(
        powerKw: power,
        voltageV: voltage,
        phase: phase == "3" ? Phase.three : Phase.single,
        cosPhi: cosphi,
      ),
    );
    final voltageResult = VoltageDropCalculator.calculate(
      currentResult: currentResult,
      lengthM: distance,
      resistanceOhmPerKm: selectedResistance,
    );
    final suitable = CableCalculator.selectByVoltageDrop(
      currentA: currentResult.currentA,
      lengthM: distance,
      voltageV: voltage,
      phase: currentResult.inputs.phase,
      material: material == "Cu"
          ? ConductorMaterial.copper
          : ConductorMaterial.aluminum,
    );

    setState(() {
      resultPercent = voltageResult.percent;
      recommendedCable = suitable?.label ?? "Daha büyük kesit gerekli";
    });
  }

  String? positiveValidator(String? value) {
    final parsed = double.tryParse(value ?? '');
    if (parsed == null || !parsed.isFinite || parsed <= 0) {
      return 'Sıfırdan büyük sayısal değer giriniz';
    }
    return null;
  }

  String getFormulaText() {
    if (phase == "3") {
      return "3 Faz:\nI = P / (√3 × V × cosφ)\nΔV = (√3 × I × L × R) / 1000";
    } else {
      return "1 Faz:\nI = P / (V × cosφ)\nΔV = (2 × I × L × R) / 1000";
    }
  }

  @override
  Widget build(BuildContext context) {
    Color resultColor = (resultPercent != null && resultPercent! > 3)
        ? Colors.red
        : Colors.green;

    return Scaffold(
      appBar: AppBar(title: Text("Gerilim Düşümü")),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              /// INPUT KARTI
              buildCard(
                child: Column(
                  children: [
                    TextFormField(
                      controller: powerController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(labelText: "Güç (kW)"),
                      validator: positiveValidator,
                    ),
                    TextFormField(
                      controller: voltageController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(labelText: "Gerilim (V)"),
                      validator: positiveValidator,
                    ),
                    TextFormField(
                      controller: distanceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(labelText: "Mesafe (m)"),
                      validator: positiveValidator,
                    ),
                  ],
                ),
              ),

              /// SEÇİM KARTI
              buildCard(
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: phase,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(value: "1", child: Text("1 Faz")),
                        DropdownMenuItem(value: "3", child: Text("3 Faz")),
                      ],
                      onChanged: (value) {
                        setState(() => phase = value!);
                      },
                    ),

                    DropdownButton<double>(
                      value: cosphi,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 1.0,
                          child: Text("Rezistif (1.0)"),
                        ),
                        DropdownMenuItem(
                          value: 0.9,
                          child: Text("Aydınlatma (0.9)"),
                        ),
                        DropdownMenuItem(
                          value: 0.85,
                          child: Text("Karışık (0.85)"),
                        ),
                        DropdownMenuItem(
                          value: 0.8,
                          child: Text("Motor (0.8)"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => cosphi = value!);
                      },
                    ),

                    DropdownButton<String>(
                      value: material,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(value: "Cu", child: Text("Bakır")),
                        DropdownMenuItem(value: "Al", child: Text("Alüminyum")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          material = value!;
                          selectedResistance =
                              currentCables.first.resistanceOhmPerKm!;
                        });
                      },
                    ),

                    DropdownButton<double>(
                      value: selectedResistance,
                      isExpanded: true,
                      items: currentCables.map<DropdownMenuItem<double>>((
                        entry,
                      ) {
                        return DropdownMenuItem<double>(
                          value: entry.resistanceOhmPerKm!,
                          child: Text(entry.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedResistance = value!);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              primaryButton("HESAPLA", calculate),

              /// SONUÇ
              if (resultPercent != null)
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      resultBox(
                        "Gerilim Düşümü",
                        "%${resultPercent!.toStringAsFixed(2)}",
                        resultColor,
                      ),

                      if (recommendedCable.isNotEmpty)
                        resultBox(
                          "Önerilen Kablo",
                          recommendedCable,
                          Colors.green,
                        ),

                      if (resultPercent! > 3)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "⚠️ %3 sınırı aşıldı!",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      if (cosphi < 0.85)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "⚠️ Düşük cosφ; proje koşullarına göre ayrıca değerlendirilmelidir",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),

                      SizedBox(height: 20),

                      Text(
                        "Kullanılan Formül:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 10),

                      Text(getFormulaText()),
                      SizedBox(height: 12),
                      Text(
                        "Ön hesap sonucudur. Bu sürümde yalnızca direnç bileşeni kullanılmaktadır; reaktans ve tesis koşulları ayrıca doğrulanmalıdır.",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
