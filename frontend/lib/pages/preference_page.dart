import 'package:dating_app/cubits/currentHomeCubit.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:dating_app/pages/test.dart';
import 'package:flutter/material.dart';
import '../models/ApartmentPreferenceState.dart';
import '../cubits/currentHomeCubit.dart';
import '../cubits/newHomePreferencesCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PreferencePage extends StatelessWidget {
  String selectedMinZimmer = '1';
  String selectedMaxZimmer = '10+';
  String selectedMinQuadratmeter = '<10';
  String selectedMaxQuadratmeter = '>200';
  String selectedMietpreisMin = '<100';
  String selectedMietpreisMax = '>2000';
  String selectedStadt = 'Berlin';

  List<String> Zimmeranzahl_Min = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10+'
  ];
  List<String> Zimmeranzahl_Max = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10+'
  ];
  List<String> Quadratmeter_Min = [
    '<10',
    '10-20',
    '20-30',
    '30-40',
    '40-50',
    '50-60',
    '60-70',
    '70-80',
    '80-90',
    '90-100',
    '100-110',
    '110-120',
    '120-130',
    '130-140',
    '140-150',
    '150-160',
    '160-170',
    '170-180',
    '180-190',
    '190-200',
    '>200'
  ];
  List<String> Quadratmeter_Max = [
    '<10',
    '10-20',
    '20-30',
    '30-40',
    '40-50',
    '50-60',
    '60-70',
    '70-80',
    '80-90',
    '90-100',
    '100-110',
    '110-120',
    '120-130',
    '130-140',
    '140-150',
    '150-160',
    '160-170',
    '170-180',
    '180-190',
    '190-200',
    '>200'
  ];
  List<String> Mietpreis_Min = [
    '<100',
    '100-200',
    '200-300',
    '300-400',
    '400-500',
    '500-600',
    '600-700',
    '700-800',
    '800-900',
    '900-1000',
    '1000-1200',
    '1200-1400',
    '1400-1600',
    '1600-1800',
    '1800-2000',
    '>2000'
  ];
  List<String> Mietpreis_Max = [
    '<100',
    '100-200',
    '200-300',
    '300-400',
    '400-500',
    '500-600',
    '600-700',
    '700-800',
    '800-900',
    '900-1000',
    '1000-1200',
    '1200-1400',
    '1400-1600',
    '1600-1800',
    '1800-2000',
    '>2000'
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('What are you looking for?'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Example for one preference, you can extend it similarly
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
                label: 'Zimmerzahl Maximum',
                value: selectedMaxZimmer, // Your state variable holding the current value
                items: Zimmeranzahl_Max, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMaxRooms(value);
                },
              ),
              buildDropdownRow(
                label: 'Minimun Quadratmeter',
                value: selectedMinQuadratmeter, // Your state variable holding the current value
                items: Quadratmeter_Min, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMinSquareMeters(value);
                },
              ),
              buildDropdownRow(
                label: 'Maximun Quadratmeter',
                value: selectedMaxQuadratmeter, // Your state variable holding the current value
                items: Quadratmeter_Max, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMaxSquareMeters(value);
                },
              ),
              buildDropdownRow(
                label: 'Minimum Miete',
                value: selectedMietpreisMin, // Your state variable holding the current value
                items: Mietpreis_Min, // Your list of options for the dropdown
                onChanged: (String? value) {
                   // Update the Cubit state
                  context.read<NewHomePreferencesCubit>().updateMinRent(value);
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
              // Add more BlocBuilders for other preferences
              ElevatedButton(
                child: const Text('Submit Preferences'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwipePage()),
                  );
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
