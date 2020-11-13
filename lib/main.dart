import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  // TextEditingController textEditingController = TextEditingController();
  //
  // void initState() {
  //   textEditingController.addListener(_printCurrentValue);
  //   super.initState();
  // }
  //
  // void _printCurrentValue() {
  //   print(textEditingController.text);
  // }
  //
  // @override
  // void dispose() {
  //   textEditingController.removeListener(_printCurrentValue);
  //   textEditingController.dispose();
  //   super.dispose();
  // }

  void _submit() {
    final form = formKey.currentState;

    if(form.validate()) {
      form.save();

      performLogin();
    }
  }

  void performLogin() {
    final snackbar = SnackBar(content: Text("$_email, $_password"));
    scaffoldKey.currentState.showSnackBar(snackbar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Form Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) => !value.contains('@')?'Invalid Email' : null,
                onSaved: (value) => _email = value,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: (value) => (value.length<6 || !value.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) ? "Please enter a valid password. Password must contain an \n Uppercase letter, Lowercase letter, a number and a special \n character (@,#,%,&)" : null,
                onSaved: (value)=> _password = value,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  _submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
