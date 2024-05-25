import 'package:carbon_foodprint_pro/login_screen.dart';
import 'package:carbon_foodprint_pro/service/predictionService.dart';
import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:flutter/material.dart';

class CarbonFoodPrint extends StatefulWidget {
  const CarbonFoodPrint({Key? key}) : super(key: key);

  @override
  State<CarbonFoodPrint> createState() => _CarbonFoodPrintState();
}

class _CarbonFoodPrintState extends State<CarbonFoodPrint> {
  TextEditingController poliklinikController = TextEditingController();
  TextEditingController hastaneIdController = TextEditingController();
  final PredictionService _predictionService = PredictionService();
  late bool _modelLoaded;
  double? _predictionResult;

  // Dropdown-related variables
  final List<String> _modelOptions = ["Surgery", "Inpatient", "ICU"];
  String? _selectedModel;

  @override
  void initState() {
    super.initState();
    _modelLoaded = false;
    _loadModel(0);  // Load the default model initially
  }

  void _loadModel(int modelIndex) async {
    try {
      await _predictionService.loadModel(modelIndex);
      setState(() {
        _modelLoaded = true;
      });
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  void _predict() async {
    if (!_modelLoaded) {
      print("Model is not loaded yet.");
      return;
    }

    try {
      double Id = double.parse(hastaneIdController.text);
      double poliklinik = double.parse(poliklinikController.text);
      double prediction = await _predictionService.predict(Id, poliklinik);
      setState(() {
        _predictionResult = prediction;
      });
    } catch (e) {
      print("Error during prediction: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: CustomColors.bodyBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: hastaneIdController,
                decoration: const InputDecoration(
                  labelText: 'Hospital ID',
                  hintText: 'Enter Hospital ID',
                ),
              ),
              TextFormField(
                controller: poliklinikController,
                decoration: const InputDecoration(
                  labelText: 'Policlinic Count',
                  hintText: 'Enter Policlinic Count',
                ),
              ),
              const SizedBox(height: 30),
              DropdownButton<String>(
                value: _selectedModel,
                hint: Text("Select Prediction Model"),
                onChanged: (value) {
                  setState(() {
                    _selectedModel = value;
                    int modelIndex = _modelOptions.indexOf(value!);
                    _loadModel(modelIndex);
                  });
                },
                items: _modelOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _predict,
                child: const Text("Predict"),
              ),
              if (_predictionResult != null)
                Text(
                  'Prediction Result: $_predictionResult',
                  style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: CustomColors.appBarColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _onLogoutPressed,
      ),
      title: const Text('Carbon FoodPrint Predictions'),
    );
  }

  void _onLogoutPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
