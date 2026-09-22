import 'package:flutter/material.dart';
import '../core/calculations/current_calculator.dart';
import '../core/calculations/fuse_calculator.dart';
import '../core/calculations/models/calculation_models.dart';

class FusePage extends StatefulWidget {
  const FusePage({super.key});

  @override
  State<FusePage> createState() => _FusePageState();
}

class _FusePageState extends State<FusePage> {
  final TextEditingController powerController = TextEditingController();
  final TextEditingController voltageController = TextEditingController();

  String phase = "3";
  double cosphi = 0.8;

  double? current;
  int? selectedFuse;
  String fuseNote = '';
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
    final currentResult = CurrentCalculator.calculate(
      CalculationInputs(
        powerKw: power,
        voltageV: voltage,
        phase: phase == "3" ? Phase.three : Phase.single,
        cosPhi: cosphi,
      ),
    );
    final result = FuseCalculator.select(currentResult.currentA);

    setState(() {
      current = currentResult.currentA;
      selectedFuse = result.nominalCurrentA;
      fuseNote = result.note;
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
    return Scaffold(
      appBar: AppBar(title: Text("Sigorta Seçimi")),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: powerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Güç (kW)"),
                validator: positiveValidator,
              ),
              TextFormField(
                controller: voltageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Gerilim (V)"),
                validator: positiveValidator,
              ),

              SizedBox(height: 10),

              DropdownButton<String>(
                value: phase,
                items: [
                  DropdownMenuItem(value: "1", child: Text("1 Faz")),
                  DropdownMenuItem(value: "3", child: Text("3 Faz")),
                ],
                onChanged: (value) {
                  setState(() {
                    phase = value!;
                  });
                },
              ),

              DropdownButton<double>(
                value: cosphi,
                items: [
                  DropdownMenuItem(value: 1.0, child: Text("Rezistif (1.0)")),
                  DropdownMenuItem(value: 0.9, child: Text("Aydınlatma (0.9)")),
                  DropdownMenuItem(value: 0.85, child: Text("Karışık (0.85)")),
                  DropdownMenuItem(value: 0.8, child: Text("Motor (0.8)")),
                ],
                onChanged: (value) {
                  setState(() {
                    cosphi = value!;
                  });
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: calculate, child: Text("HESAPLA")),

              SizedBox(height: 20),

              if (current != null)
                Text("Akım: ${current!.toStringAsFixed(2)} A"),

              if (selectedFuse != null)
                Text(
                  "Önerilen ön nominal değer: $selectedFuse A",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

              if (selectedFuse != null)
                Text(
                  'Açma eğrisi yük karakteristiğine göre ayrıca seçilmelidir.',
                  style: TextStyle(color: Colors.orange),
                ),
              if (fuseNote.isNotEmpty) Text(fuseNote),
            ],
          ),
        ),
      ),
    );
  }
}
