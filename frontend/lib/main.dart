import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/preference_page.dart';
import 'pages/swipe_page.dart';
import 'pages/profile_page.dart';

import '../models/ApartmentPreferenceState.dart';
import '../cubits/currentHomeCubit.dart';
import '../cubits/newHomePreferencesCubit.dart';
import '../api/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Home Ring Swapping App';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentHomeCubit>(
          create: (context) => CurrentHomeCubit(),
        ),
        BlocProvider<NewHomePreferencesCubit>(
          create: (context) => NewHomePreferencesCubit(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: MyStatefulWidget(),
        ),
      ),
    );
  }
}
  
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userid = '';
  bool apiCall = false;

  void _call_login_api(){
    login(username: nameController.text, password: passwordController.text).then((userid){
      setState(() {
        this.userid = userid;
      });
      print('RESULT');
      print('PUSHING');
      context.read<CurrentHomeCubit>().updateId(userid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PreferencePage()),);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                setState((){
                    apiCall=true; // Set state like this
                    _call_login_api();
                  });
                print(nameController.text);
                print(passwordController.text);
                //Future<String>? _userid_future;
              },
            ),
          ],
        ));
  }
}
