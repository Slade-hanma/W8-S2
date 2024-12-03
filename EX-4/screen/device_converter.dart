// lib\EX-4\screen\device_converter.dart

import 'package:flutter/material.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final TextEditingController _controller = TextEditingController();
  String? _selectedDevice;
  double _convertedAmount = 0.0;

  final Map<String, double> _conversionRates = {
    'Euro': 0.85,
    'Riels': 4080.0,
    'Dong': 23000.0,
  };

  @override
  void initState() {
    super.initState();
    _selectedDevice = 'Euro'; // Default selection
  }

  void _convert() {
    final double amountInDollars = double.tryParse(_controller.text) ?? 0.0;
    setState(() {
      _convertedAmount = amountInDollars * (_conversionRates[_selectedDevice] ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.money,
              size: 60,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Amount in dollars:"),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollar',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number, // Only numbers
              onChanged: (value) {
                _convert(); // Automatically convert on input change
              },
            ),
            const SizedBox(height: 30),
            const Text("Select Device:"),
            DropdownButton<String>(
              value: _selectedDevice,
              dropdownColor: Colors.orange,
              items: _conversionRates.keys.map((String device) {
                return DropdownMenuItem<String>(
                  value: device,
                  child: Text(device, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDevice = newValue!;
                  _convert(); // Recalculate conversion on selection change
                });
              },
            ),
            const SizedBox(height: 30),
            const Text("Amount in selected device:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                '${_convertedAmount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
