// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:tubes_iot/Pages/Riwayat.dart';

// class GasPage extends StatefulWidget {
//   final String title;

//   const GasPage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   _GasPageState createState() => _GasPageState();
// }

// class _GasPageState extends State<GasPage> {
//   late DatabaseReference _gasRef;
//   late StreamSubscription<DatabaseEvent> _gasSubscription;
//   int _gasValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     _gasRef = FirebaseDatabase.instance.reference().child("nilai_asap");
//     _gasSubscription = _gasRef.onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         dynamic value = event.snapshot.value;
//         if (value is int) {
//           setState(() {
//             _gasValue = value;
//           });
//         } else {
//           print("Nilai tidak valid");
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _gasSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     widget.title,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.history),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RiwayatPage(
//                           title: '',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Column(
//               children: [
//                 Icon(
//                   Icons.warning,
//                   color: Colors.red,
//                   size: 48,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Indikator Peringatan',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 22),
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(
//                             'assets/images/Alert.png',
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.contain,
//                           ),
//                           SizedBox(height: 20),
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('Matikan Alarm'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Data Real-Time',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Konsentrasi Gas: $_gasValue',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Tips saat terjadi kebocoran gas❗🔥',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '1. Lepas Regulator\n2. Buka Pintu dan Jendela\n3. Bawa ke tempat terbuka\n4. Tutup dengan handuk basah jika keluar api\n5. Ganti perlengkapan kompor gas',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Image.asset(
//               'assets/images/Toxic.png',
//               width: 200,
//               height: 200,
//               fit: BoxFit.contain,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tubes_iot/Pages/Riwayat.dart';
import 'package:audioplayers/audioplayers.dart';

class GasPage extends StatefulWidget {
  final String title;

  const GasPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _GasPageState createState() => _GasPageState();
}

class _GasPageState extends State<GasPage> {
  late DatabaseReference _gasRef;
  late StreamSubscription<DatabaseEvent> _gasSubscription;
  int _gasValue = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _gasRef = FirebaseDatabase.instance.reference().child("nilai_asap");
    _gasSubscription = _gasRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        dynamic value = event.snapshot.value;
        if (value is int) {
          setState(() {
            _gasValue = value;
          });
          if (_gasValue > 999) {
            _showAlarmDialog();
            _playAlarmSound();
          }
        } else {
          print("Nilai tidak valid");
        }
      }
    });
  }

  @override
  void dispose() {
    _gasSubscription.cancel();
    super.dispose();
  }

  void _showAlarmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/Alert.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _stopAlarmSound();
                  },
                  child: Text('Matikan Alarm'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _playAlarmSound() async {
    await _audioPlayer.play(AssetSource('assets/sounds/alarm.mp3'));
  }

  void _stopAlarmSound() {
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiwayatPage(
                          title: '',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 48,
                ),
                SizedBox(height: 8),
                Text(
                  'Indikator Peringatan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/Alert.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Matikan Alarm'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Real-Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Konsentrasi Gas: $_gasValue',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tips saat terjadi kebocoran gas: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Lepas Regulator\n2. Buka Pintu dan Jendela\n3. Bawa ke tempat terbuka\n4. Tutup dengan handuk basah jika keluar api\n5. Ganti perlengkapan kompor gas',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/Toxic.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
