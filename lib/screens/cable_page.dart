import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';
import '../core/calculations/cable_calculator.dart';
import '../core/calculations/current_calculator.dart';
import '../core/calculations/models/calculation_models.dart';

class CablePage extends StatefulWidget {
  const CablePage({super.key});

  @override
  State<CablePage> createState() => _CablePageState();
}

class _CablePageState extends State<CablePage> {
  final TextEditingController powerController = TextEditingController();
  final TextEditingController voltageController = TextEditingController();

  String phase = "3";
  double cosphi = 0.8;

  double? current;
  String copperCable = "";
  String aluminumCable = "Veri doğrulanmadı";
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    powerController.dispose();
    voltageController.dispose();
    super.dispose();
  }

  void calculate() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final power = double.parse(powerController.text);
    final voltage = double.parse(voltageController.text);
    final result = CurrentCalculator.calculate(
      CalculationInputs(
        powerKw: power,
        voltageV: voltage,
        phase: phase == "3" ? Phase.three : Phase.single,
        cosPhi: cosphi,
      ),
    );
    final copper = CableCalculator.selectByAmpacity(
      currentA: result.currentA,
      material: ConductorMaterial.copper,
    );

    setState(() {
      current = result.currentA;
      copperCable = copper?.label ?? "400 mm² üstü veya veri dışında";
      aluminumCable = "Alüminyum ampacity verisi doğrulanmadı";
    });
  }

  String? positiveValidator(String? value) {
    final parsed = double.tryParse(value ?? '');
    if (parsed == null || !parsed.isFinite || parsed <= 0) {
      return 'Sıfırdan büyük sayısal değer giriniz';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Color currentColor = (current != null && current! > 100)
        ? Colors.red
        : Colors.green;

    return Scaffold(
      appBar: AppBar(title: Text("Kablo Kesit Hesabı")),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              /// INPUT
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
                  ],
                ),
              ),

              /// SEÇİM
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
                  ],
                ),
              ),

              SizedBox(height: 10),

              primaryButton("HESAPLA", calculate),

              /// SONUÇ
              if (current != null)
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      resultBox(
                        "Akım",
                        "${current!.toStringAsFixed(2)} A",
                        currentColor,
                      ),

                      SizedBox(height: 10),

                      resultBox("Bakır Kablo", copperCable, Colors.orange),

                      resultBox("Alüminyum Kablo", aluminumCable, Colors.blue),

                      SizedBox(height: 12),
                      Text(
                        "Ön hesap sonucudur. Kablo seçimi; döşeme şekli, sıcaklık, gruplanma ve koruma koordinasyonu ile ayrıca doğrulanmalıdır.",
                        style: TextStyle(color: Colors.orange),
                      ),

                      if (current! > 100)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "⚠️ Yüksek akım, kablo kesitini dikkatle kontrol edin",
                            style: TextStyle(color: Colors.red),
                          ),
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
