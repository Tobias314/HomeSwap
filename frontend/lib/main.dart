import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/preference_page.dart';
import 'pages/swipe_page.dart';
import 'pages/profile_page.dart';

import '../models/ApartmentPreferenceState.dart';
import '../cubits/currentHomeCubit.dart';
import '../cubits/newHomePreferencesCubit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Home Swap';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFEFB20A), brightness: Brightness.light),
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.raleway(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: GoogleFonts.raleway(
              fontSize: 20,
            ),
            displaySmall: GoogleFonts.rubik(
              fontSize: 20,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
            backgroundColor: const Color(0xFFEFB20A),
          ),
          body: const MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                child: const Image(
                  image: AssetImage('assets/images/logo1.png'),
                  width: 400,
                  height: 400,
                )),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                print(nameController.text);
                print(passwordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ));
  }
}
