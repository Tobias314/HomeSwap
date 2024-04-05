import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class PreferencePage extends StatefulWidget {
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
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
        title: Text('What are you looking for?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Table(
              children: [
                buildDropdownRow(
                  label: 'Zimmerzahl Minimum',
                  value: selectedMinZimmer,
                  items: Zimmeranzahl_Min,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMinZimmer = value ?? selectedMinZimmer;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Zimmerzahl Maximum',
                  value: selectedMaxZimmer,
                  items: Zimmeranzahl_Max,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMaxZimmer = value ?? selectedMaxZimmer;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Quadratmeter Minimum',
                  value: selectedMinQuadratmeter,
                  items: Quadratmeter_Min,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMinQuadratmeter =
                          value ?? selectedMinQuadratmeter;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Quadratmeter Maximum',
                  value: selectedMaxQuadratmeter,
                  items: Quadratmeter_Max,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMaxQuadratmeter =
                          value ?? selectedMaxQuadratmeter;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Mietpreis Minimum',
                  value: selectedMietpreisMin,
                  items: Mietpreis_Min,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMietpreisMin = value ?? selectedMietpreisMin;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Mietpreis Maximum',
                  value: selectedMietpreisMax,
                  items: Mietpreis_Max,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMietpreisMax = value ?? selectedMietpreisMax;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Stadt',
                  value: selectedStadt,
                  items: Stadt,
                  onChanged: (String? value) {
                    setState(() {
                      selectedStadt = value ?? selectedStadt;
                    });
                  },
                ),
              ],
            ),
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

  TableRow buildDropdownRow({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              value: value,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
