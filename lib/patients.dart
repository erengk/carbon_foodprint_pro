import 'package:carbon_foodprint_pro/login_screen.dart';
import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Patients extends StatefulWidget {

  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  TextEditingController poliklinikController = TextEditingController();
  TextEditingController ameliyatController = TextEditingController();
  TextEditingController servisController = TextEditingController();
  TextEditingController yogunBakimController = TextEditingController();

  var poliklinikResult = "Result will be displayed here";
  var ameliyatResult = "Result will be displayed here";
  var servisResult = "Result will be displayed here";
  var yogunBakimResult = "Result will be displayed here";
  late var interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/linear.tflite');
  }

  void performPoliklinikPrediction() {
    int x = int.parse(poliklinikController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      poliklinikResult = "Result: " + output[0][0].toString();
    });
  }

  void performAmeliyatPrediction() {
    int x = int.parse(ameliyatController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      ameliyatResult = "Result: " + output[0][0].toString();
    });
  }

  void performServisPrediction() {
    int x = int.parse(servisController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      servisResult = "Result: " + output[0][0].toString();
    });
  }

  void performYogunBakimPrediction() {
    int x = int.parse(yogunBakimController.text);
    var input = [x];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);
    setState(() {
      yogunBakimResult = "Result: " + output[0][0].toString();
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
                controller: poliklinikController,
                decoration: const InputDecoration(
                    labelText: 'Poliklinik Sayısı',
                    hintText: 'Poliklinik Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performPoliklinikPrediction,
                child: const Text("Predict"),
              ),
              Text(poliklinikResult),
              TextFormField(
                controller: ameliyatController,
                decoration: const InputDecoration(
                    labelText: 'Ameliyat Sayısı',
                    hintText: 'Ameliyat Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performAmeliyatPrediction,
                child: const Text("Predict"),
              ),
              Text(ameliyatResult),
              TextFormField(
                controller: servisController,
                decoration: const InputDecoration(
                    labelText: 'Servis Yatan Hasta Sayısı',
                    hintText: 'Servis Yatan Hasta Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performServisPrediction,
                child: const Text("Predict"),
              ),
              Text(servisResult),
              TextFormField(
                controller: yogunBakimController,
                decoration: const InputDecoration(
                    labelText: 'Yoğun Bakım Yatan Hasta Sayısı',
                    hintText: 'Yoğun Bakım Yatan Hasta Sayısını Giriniz'),
              ),
              ElevatedButton(
                onPressed: performYogunBakimPrediction,
                child: const Text("Predict"),
              ),
              Text(yogunBakimResult),
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
        title: const Text('Patient Predictions')
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
