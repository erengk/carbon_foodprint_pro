import 'package:carbon_foodprint_pro/homeScreen.dart';
import 'package:carbon_foodprint_pro/service/authenticationService.dart';
import 'package:carbon_foodprint_pro/widgets/popup.dart';
import 'package:carbon_foodprint_pro/utils/customColors.dart';
import 'package:carbon_foodprint_pro/widgets/customElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String logoImage = "assets/logo.png";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        title: const Text('Giriş Yap'),
      ),
      backgroundColor: CustomColors.bodyBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              imageContainer(logoImage, height),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: "kullanıcı adı"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Şifre'),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                onPressed: () async {
                  String uid = await AuthenticationService().signIn(
                    "${_usernameController.text}@mail.com",
                    _passwordController.text,
                  );
                  if (uid == "null") {
                    popUp(context, "Hatalı Giriş",
                        "Kullanıcı adı veya Şifreniz Hatalı");
                  } else if (uid == "HnwBNl5CVGbzWBRUDU40TBhhLKw1") {
                    Navigator.pushNamed(context, "/adminRegisterScreen");
                  } else if (uid == "yk1rRtMH7QZfCKGKMYyvq1pXS823") {
                    Navigator.pushNamed(context, "/adminPage");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
                buttonText: 'Giriş Yap',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container imageContainer(String logoImage, double height) {
    return Container(
      height: 180,
      width: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(logoImage),
        ),
      ),
    );
  }
}
