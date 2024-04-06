import 'package:dating_app/cubits/currentHomeCubit.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:dating_app/pages/test.dart';
import 'package:flutter/material.dart';
import '../models/ApartmentPreferenceState.dart';
import '../cubits/currentHomeCubit.dart';
import '../cubits/newHomePreferencesCubit.dart';
import '../api/fetch_options.dart';
import '../api/set_user_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PreferencePage extends StatelessWidget {
  String selectedMinZimmer = '1';
  String selectedMinQuadratmeter = '10';
  String selectedMietpreisMax = '2000';
  String selectedStadt = 'Berlin';

  List<String> Zimmeranzahl_Min = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
  ];

  List<String> Quadratmeter_Min = [
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100',
    '110',
    '120',
    '130',
    '140',
    '150',
    '160',
    '170',
    '180',
    '190',
    '200'
  ];

  List<String> Mietpreis_Max = [
    '100',
    '200',
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900',
    '1000',
    '1200',
    '1400',
    '1600',
    '1800',
    '2000'
  ];
  List<String> Stadt = [
    'Aachen',
    'Augsburg',
    'Berlin',
    'Bielefeld',
    'Bochum',
    'Bonn',
    'Bottrop',
    'Braunschweig',
    'Bremen',
    'Bremerhaven',
    'Chemnitz',
    'Cottbus',
    'Darmstadt',
    'Dortmund',
    'Dresden',
    'Duisburg',
    'Düsseldorf',
    'Erfurt',
    'Essen',
    'Esslingen',
    'Flensburg',
    'Frankfurt',
    'Freiburg',
    'Fürth',
    'Gelsenkirchen',
    'Gera',
    'Göttingen',
    'Gütersloh',
    'Hagen',
    'Halle',
    'Hamburg',
    'Hamm',
    'Hannover',
    'Heidelberg',
    'Heilbronn',
    'Herne',
    'Hildesheim',
    'Ingolstadt',
    'Iserlohn',
    'Jena',
    'Kaiserslautern',
    'Karlsruhe',
    'Kassel',
    'Kiel',
    'Koblenz',
    'Köln',
    'Konstanz',
    'Krefeld',
    'Leipzig',
    'Leverkusen',
    'Ludwigshafen',
    'Lübeck',
    'Lüdenscheid',
    'Lüneburg',
    'Magdeburg',
    'Mainz',
    'Mannheim',
    'Marl',
    'Minden',
    'Mönchengladbach',
    'Mülheim',
    'München',
    'Münster',
    'Neumünster',
    'Neuss',
    'Nürnberg',
    'Oberhausen',
    'Offenbach',
    'Oldenburg',
    'Osnabrück',
    'Paderborn',
    'Pforzheim',
    'Potsdam',
    'Ratingen',
    'Reutlingen',
    'Remscheid',
    'Regensburg',
    'Rostock',
    'Saarbrücken',
    'Salzgitter',
    'Schwerin',
    'Siegen',
    'Solingen',
    'Stuttgart',
    'Trier',
    'Ulm',
    'Velbert',
    'Viersen',
    'Villingen-Schwenningen',
    'Wiesbaden',
    'Wilhelmshaven',
    'Wuppertal',
    'Würzburg',
    'Zwickau'
  ];

  void save_preferences(String userid, String min_rooms, String min_size, String max_price, BuildContext context){
    print(userid);
      setUserPreferences(userid: userid, max_price: max_price, min_rooms: min_rooms, min_size: min_size).then((userid){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SwipePage()));
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Wonach suchst du?'),
          backgroundColor: const Color(0xFFEFB20A),
          titleTextStyle: const TextStyle(  
              color: Colors.white,
              fontSize: 30,
              )
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Präferenzen',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              buildDropdownRow(
                label: 'Zimmerzahl Minimum',
                value: selectedMinZimmer, // Your state variable holding the current value
                items: Zimmeranzahl_Min, // Your list of options for the dropdown
                onChanged: (String? value) {
                  // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMinRooms(value);
                },
              ),
              buildDropdownRow(
                label: 'Minimum Quadratmeter',
                value: selectedMinQuadratmeter, // Your state variable holding the current value
                items: Quadratmeter_Min, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMinSquareMeters(value);
                },
              ),
              buildDropdownRow(
                label: 'Maximum Miete',
                value: selectedMietpreisMax, // Your state variable holding the current value
                items: Mietpreis_Max, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMaxRent(value);
                },
              ),
              buildDropdownRow(
                label: 'Stadt',
                value: selectedStadt, // Your state variable holding the current value
                items: Stadt, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateCity(value);
                },
              ),
              const SizedBox(height: 20,),
              // Add more BlocBuilders for other preferences
              ElevatedButton(
                child: const Text('weiter'),
                onPressed: () {
                  save_preferences(context.read<CurrentHomeCubit>().state.id, context.read<NewHomePreferencesCubit>().state.minRooms,
                                   context.read<NewHomePreferencesCubit>().state.minSquareMeters, context.read<NewHomePreferencesCubit>().state.maxRent,
                                   context);
                },
              ),
            ],
          ),
        ),
      );
  }

  Widget buildDropdownRow({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  
   
  
}
