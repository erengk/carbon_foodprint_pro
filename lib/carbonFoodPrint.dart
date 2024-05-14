import 'package:carbon_foodprint_pro/login_screen.dart';
import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CarbonFoodPrint extends StatefulWidget {

  const CarbonFoodPrint({super.key});

  @override
  State<CarbonFoodPrint> createState() => _CarbonFoodPrintState();
}

class _CarbonFoodPrintState extends State<CarbonFoodPrint> {
  TextEditingController sterilizasyonController = TextEditingController();
  TextEditingController camasirhaneController = TextEditingController();
  TextEditingController laboratuvarController = TextEditingController();
  TextEditingController yemekhaneController = TextEditingController();
  TextEditingController goruntulemeController = TextEditingController();
  TextEditingController kantinController = TextEditingController();

  var sterilizasyonResult = "Result will be displayed here";
  var camasirhaneResult = "Result will be displayed here";
  var laboratuvarResult = "Result will be displayed here";
  var goruntulemeResult = "Result will be displayed here";
  var yemekhaneResult = "Result will be displayed here";
  var kantinResult = "Result will be displayed here";
  late var interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/linear.tflite');
  }

  void performSterilizasyonPrediction() {
    int x = int.parse(sterilizasyonController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      sterilizasyonResult = "Result: " + output[0][0].toString();
    });
  }

  void performCamasirhanePrediction() {
    int x = int.parse(camasirhaneController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      camasirhaneResult = "Result: " + output[0][0].toString();
    });
  }

  void performLaboratuvarPrediction() {
    int x = int.parse(laboratuvarController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      laboratuvarResult = "Result: " + output[0][0].toString();
    });
  }

  void performYemekhanePrediction() {
    int x = int.parse(yemekhaneController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      yemekhaneResult = "Result: " + output[0][0].toString();
    });
  }

  void performGoruntulemePrediction() {
    int x = int.parse(goruntulemeController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      goruntulemeResult = "Result: " + output[0][0].toString();
    });
  }

  void performKantinPrediction() {
    int x = int.parse(kantinController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      kantinResult = "Result: " + output[0][0].toString();
    });
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
                controller: sterilizasyonController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performSterilizasyonPrediction,
                child: const Text("Predict"),
              ),
              Text(sterilizasyonResult),
              TextFormField(
                controller: camasirhaneController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performCamasirhanePrediction,
                child: const Text("Predict"),
              ),
              Text(camasirhaneResult),
              TextFormField(
                controller: laboratuvarController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performLaboratuvarPrediction,
                child: const Text("Predict"),
              ),
              Text(laboratuvarResult),
              TextFormField(
                controller: yemekhaneController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performYemekhanePrediction,
                child: const Text("Predict"),
              ),
              Text(yemekhaneResult),
              TextFormField(
                controller: goruntulemeController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performGoruntulemePrediction,
                child: const Text("Predict"),
              ),
              Text(goruntulemeResult),
              TextFormField(
                controller: kantinController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performKantinPrediction,
                child: const Text("Predict"),
              ),
              Text(kantinResult),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: CustomColors.appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onLogoutPressed,
        ),
        title: const Text('Carbon Foodprint Predictions')
    );
  }
  void _onLogoutPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
