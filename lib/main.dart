import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/diamonds.dart';
import 'package:geopattern_flutter/patterns/mosaic_squares.dart';
import 'package:geopattern_flutter/patterns/sine_waves.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppOne(),
    );
  }
}

class MyAppOne extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppOne> {
  static String newTaskTile = '';
  var hash = sha1.convert(utf8.encode('$newTaskTile')).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.green,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: LayoutBuilder(builder: (context, constraints) {
                var pattern = SineWaves.fromHash(hash);
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter:
                          FullPainter(pattern: pattern, background: Colors.red),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: 'Enter a search term',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                ),
                                filled: true,
                                fillColor: Colors.white),
//                  textAlign: TextAlign.center,
                            autofocus: false,
                            onChanged: (value) {
                              newTaskTile = value;
                            },
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            print(newTaskTile);
                            setState(() {
                              print(pattern.size);
                              pattern = SineWaves.fromHash(sha1
                                  .convert(utf8.encode('$newTaskTile'))
                                  .toString());
                              print(pattern.size);
                            });
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Color(0xFFF4a780),
                          ),
                          color: Color(0xFFf6e3d1),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
