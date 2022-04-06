import 'package:flutter/material.dart';
import 'package:untitled1/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool ispassw = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  defualtFormField(
                    controller: emailcontroller,
                    type: TextInputType.emailAddress,
                    lable: 'email address',
                    prefix: Icons.email,
                    textValidate: 'email must not be is empty',
                    onChange: (value) {
                      print(value);
                    },
                    onTap: () {
                      print('onTap ontap');
                    },
                    onSubmit: (value) {
                      if (formKey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  defualtFormField(
                    controller: passwordcontroller,
                    type: TextInputType.visiblePassword,
                    lable: 'password',
                    textValidate: 'password must not be is empty',
                    prefix: Icons.lock,
                    sufix: ispassw ? Icons.visibility_off : Icons.visibility,
                    ispassword: ispassw,
                    onChange: (value) {
                      print(value);
                    },
                    sufixPressed: () {
                      setState(() {
                        ispassw = !ispassw;
                      });
                    },
                    onTap: () {
                      print('onTap ontap');
                    },
                    onSubmit: (value) {
                      if (formKey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  defualtButton(
                    text: 'login',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account ?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register Now'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
