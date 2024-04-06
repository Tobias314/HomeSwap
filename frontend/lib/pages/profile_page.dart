import 'package:dating_app/api/set_user_profile.dart';
import 'package:dating_app/pages/preference_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../cubits/currentHomeCubit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedZimmer = '1';
  String selectedQuadratmeter = '10';
  String selectedMietpreis = '100';
  String selectedStadt = 'Berlin';

  List<String> Zimmeranzahl = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

List<String> Quadratmeter = [
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
 
  List<String> Mietpreis = [
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

  void save_profile(String userid, String rooms, String size, String price, BuildContext context){
    print(userid);
      setUserProfile(userid: userid, price: price, rooms: rooms, size: size).then((userid){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PreferencePage()));
    });
  }
  
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
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Was bietest du an?'),
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
                'eigene Angaben',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
            
              buildDropdownRow(
                label: 'Zimmerzahl',
                value: selectedZimmer,
                items: Zimmeranzahl,
                onChanged: (String? value) {
                  // Update the Cubit state
                  context.read<CurrentHomeCubit>().updateMinRooms(value);
                },
              ),
              buildDropdownRow(
                label: 'Quadratmeter',
                value: selectedQuadratmeter,
                items: Quadratmeter,
                onChanged: (String? value) {
                  // Update the Cubit state
                  context.read<CurrentHomeCubit>().updateMinSquareMeters(value);
                },
              ),
              buildDropdownRow(
                label: 'Mietpreis',
                value: selectedMietpreis,
                items: Mietpreis,
                onChanged: (String? value) {
                  // Update the Cubit state
                  context.read<CurrentHomeCubit>().updateMaxRent(value);
                },
              ),
        
              buildDropdownRow(
                label: 'Stadt',
                value: selectedStadt,
                items: Stadt,
                onChanged: (String? value) {
                  // Update the Cubit state
                  context.read<CurrentHomeCubit>().updateCity(value);
                },
              ),
            
              // Photo upload
              const SizedBox(height: 20),
              const Text(
                'Bitte sende uns ein Foto Ihrer Wohnung per E-Mail an homeswap@hack.hpi.com, wir fügen es dann deinem Profil hinzu.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ElevatedButton(
                    child: const Text('weiter'),
                    onPressed: () {
                      
                      save_profile(context.read<CurrentHomeCubit>().state.id, context.read<CurrentHomeCubit>().state.minRooms,
                                   context.read<CurrentHomeCubit>().state.minSquareMeters, context.read<CurrentHomeCubit>().state.maxRent,
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize:20),
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
