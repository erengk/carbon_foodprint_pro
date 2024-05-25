import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionService {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;
  final List<String> _modelFiles = [
    'assets/Surgery_model.tflite',
    'assets/Inpatient_model.tflite',
    'assets/ICU_model.tflite',
    'assets/Sterilization_model.tflite',
    'assets/Refectory_model.tflite',
    'assets/Cafeteria_model.tflite',
    'assets/Laboratory_model.tflite',
    'assets/Radiology_model.tflite',
    'assets/Laundry_model.tflite'
  ];

  bool get isModelLoaded => _isModelLoaded;

  Future<void> loadModel(int modelIndex) async {
    if (modelIndex < 0 || modelIndex >= _modelFiles.length) {
      throw Exception("Model index out of range");
    }

    try {
      _interpreter = await Interpreter.fromAsset(_modelFiles[modelIndex]);
      _isModelLoaded = true;
      print("Loaded model: ${_modelFiles[modelIndex]}");
    } catch (e) {
      print("Failed to load model: $e");
      _isModelLoaded = false;
    }
  }

  Future<double> predict(double hastaneId, double poliklinikSayisi) async {
    if (!_isModelLoaded) {
      throw Exception("Model not loaded");
    }

    var input = [hastaneId, poliklinikSayisi];
    var output = List.filled(1, 0.0); // Adjust size according to your model's output

    _interpreter.run(input, output);
    return output[0];
  }
}
