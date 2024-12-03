import 'package:flutter/material.dart';
import '../controllers/calculo_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  double km = 0.0;
  double precioPorLitro = 0.0;
  double dineroGastado = 0.0;
  int horas = 0;
  int minutos = 0;
  String resultado = '';

  void calcular() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final consumo = CalculoController.calcularConsumo(
        km: km,
        precioPorLitro: precioPorLitro,
        dineroGastado: dineroGastado,
        horas: horas,
        minutos: minutos,
      );
      setState(() {
        resultado = '''
Litros Consumidos: ${consumo.litrosConsumidos.toStringAsFixed(2)} L
Litros por Km: ${consumo.litrosPorKm.toStringAsFixed(4)} L/km
Costo por Km: \$${consumo.costoPorKm.toStringAsFixed(2)}
Litros por 100 Km: ${consumo.litrosPor100Km.toStringAsFixed(2)} L
Costo por 100 Km: \$${consumo.costoPor100Km.toStringAsFixed(2)}
Velocidad Media: ${consumo.velocidadMediaKmh.toStringAsFixed(2)} km/h
Velocidad Media: ${consumo.velocidadMediaMs.toStringAsFixed(2)} m/s
''';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Consumo de Gasolina'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ingrese los datos:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Kilómetros Recorridos',
                onSaved: (value) => km = double.parse(value!),
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: 'Precio por Litro',
                onSaved: (value) => precioPorLitro = double.parse(value!),
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: 'Dinero Gastado',
                onSaved: (value) => dineroGastado = double.parse(value!),
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: 'Horas de Viaje',
                onSaved: (value) => horas = int.parse(value!),
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: 'Minutos de Viaje',
                onSaved: (value) => minutos = int.parse(value!),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calcular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              if (resultado.isNotEmpty)
                Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      resultado,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String?) onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Campo obligatorio' : null,
        onSaved: onSaved,
      ),
    );
  }
}
