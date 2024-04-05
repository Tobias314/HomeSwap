import 'package:dating_app/pages/preference_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedZimmer = '1';
  String selectedQuadratmeter = '<10';
  String selectedMietpreis = '<100';
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
    '10+'
  ];

  List<String> Quadratmeter = [
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
 
  List<String> Mietpreis = [
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
        title: Text('What do you have to offer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please fill in information about your appartment:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Table(
              children: [
                buildDropdownRow(
                  label: 'Zimmerzahl',
                  value: selectedZimmer,
                  items: Zimmeranzahl,
                  onChanged: (String? value) {
                    setState(() {
                      selectedZimmer = value ?? selectedZimmer;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Quadratmeter',
                  value: selectedQuadratmeter,
                  items: Quadratmeter,
                  onChanged: (String? value) {
                    setState(() {
                      selectedQuadratmeter = value ?? selectedQuadratmeter;
                    });
                  },
                ),
                buildDropdownRow(
                  label: 'Mietpreis',
                  value: selectedMietpreis,
                  items: Mietpreis,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMietpreis = value ?? selectedMietpreis;
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

            // Photo upload
            SizedBox(height: 20),
            Text(
              'Please send us a photo of your appartment via E-Mail to humble@hack.hpi.com, we will add this to your profile.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreferencePage()),
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
