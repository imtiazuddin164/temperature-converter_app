
import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {

  final TextEditingController temperatureController =
  TextEditingController();

  String selectedConversion = 'Celsius to Fahrenheit';

  String? result;
  String? errorMessage;

  void calculateTemperature() {
    String input = temperatureController.text.trim();

    if (input.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a temperature value.';
        result = null;
      });
      return;
    }

    double? temperature = double.tryParse(input);

    if (temperature == null || !temperature.isFinite) {
      setState(() {
        errorMessage = 'Please enter a valid number.';
        result = null;
      });
      return;
    }

    double convertedTemperature;
    String unit;

    if (selectedConversion == 'Celsius to Fahrenheit') {
      convertedTemperature = (temperature * 9 / 5) + 32;
      unit = '°F';
    } else {
      convertedTemperature = (temperature - 32) * 5 / 9;
      unit = '°C';
    }

    setState(() {
      result =
      '${convertedTemperature.toStringAsFixed(2)} $unit';
      errorMessage = null;
    });
  }

  @override
  void dispose() {
    temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 30),

            const Text(
              'Enter Temperature',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: temperatureController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter temperature value',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
              ),
              onChanged: (value) {
                setState(() {
                  errorMessage = null;
                  result = null;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Conversion Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedConversion,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Celsius to Fahrenheit',
                  child: Text('Celsius to Fahrenheit (°C to °F)'),
                ),
                DropdownMenuItem(
                  value: 'Fahrenheit to Celsius',
                  child: Text('Fahrenheit to Celsius (°F to °C)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedConversion = value;
                    result = null;
                    errorMessage = null;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: calculateTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 25),

            if (errorMessage != null)
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),

            if (result != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Converted Temperature',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        result!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
