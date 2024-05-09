import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController numberController = TextEditingController();
  var result = "Result will be displayed here";
  late var interpreter;

  @override
  initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/linear.tflite');
  }

  performAction() {
    int x = int.parse(numberController.text);

    // For ex: if input tensor shape [1,5] and type is float32
    var input = [x];

    // if output tensor shape [1,2] and type is float32
    var output = List.filled(1*1, 0).reshape([1,1]);

    // inference
    interpreter.run(input, output);

    // print the output
    print(output);
    result = "Result: " + output[0][0].toString();
    setState(() {
      result;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prediction Form'),
        backgroundColor: CustomColors.scaffoldBackgroundColor,
      ),
      backgroundColor: CustomColors.bodyBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget> [
                    TextFormField(
                    controller: numberController,
                    decoration:
                    const InputDecoration(labelText: 'Poliklinik Sayısı', hintText: 'Poliklinik Sayısını Giriniz'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Lütfen bir giriş yapınız';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      performAction();
                    },
                    child: Text("Predict"),
                  ),
                  Text(result),
                  ],
              ),
              ),
              /*
              Expanded(
                child: Column(
                  children: <Widget> [
                    TextFormField(
                      controller: numberController,
                      decoration:
                      const InputDecoration(labelText: 'Ameliyat Sayısı', hintText: 'Ameliyat Sayısını Giriniz'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Lütfen bir giriş yapınız';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        performAction();
                      },
                      child: Text("Predict"),
                    ),
                    Text(result),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget> [
                    TextFormField(
                      controller: numberController,
                      decoration:
                      const InputDecoration(labelText: 'Servis Yatan Hasta Sayısı', hintText: 'Servis Yatan Hasta Sayısını Giriniz'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Lütfen bir giriş yapınız';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        performAction();
                      },
                      child: Text("Predict"),
                    ),
                    Text(result),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget> [
                    TextFormField(
                      controller: numberController,
                      decoration:
                      const InputDecoration(labelText: 'Yoğun Bakım Yatan Hasta Sayısı', hintText: 'Yoğun Bakım Yatan Hasta Sayısını Giriniz'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Lütfen bir giriş yapınız';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        performAction();
                      },
                      child: Text("Predict"),
                    ),
                    Text(result),
                  ],
                ),
              ),
              
               */
            ],
          ),
        ),
      ),
    );
  }
}
