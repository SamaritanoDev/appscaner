

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      home: MyCodeBar(),
    );
  }
}

class MyCodeBar extends StatefulWidget {
  const MyCodeBar({Key? key}) : super(key: key);

  @override
  State<MyCodeBar> createState() => _MyCodeBarState();
}

class _MyCodeBarState extends State<MyCodeBar> {
  String _counter="", _value = "";

  Future _escanercode() async {
    _counter = await FlutterBarcodeScanner.scanBarcode("#E8EAF6", "Cancelar", true, ScanMode.BARCODE);
    setState(() {
      _value = _counter;
    });
  }

  Future _copyClipboard() async {
    await FlutterClipboard.copy(_value);
  }

  void _launchURL(String url) async => 
    await canLaunchUrlString(url) ? await launchUrlString(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("QR Code Scanner"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: FractionalOffset.bottomLeft,
            colors: [
              Colors.cyan[700]!,
              Colors.cyan[200]!,
              Colors.cyan[100]!
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: const Text(
                  "El valor es:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                subtitle: TextButton(
                  child: Text(
                    _value,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  onPressed: () => _launchURL(_value.toString()),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _copyClipboard,
            backgroundColor: Colors.black,
            child: const Icon(Icons.paste, size: 30),
          ),
          FloatingActionButton(
            onPressed: _escanercode,
            backgroundColor: Colors.black,
            child: const Icon(Icons.qr_code_scanner_sharp, size: 30),
          )
        ],
      ),
    );
  }
}
