import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyCodeBar(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: const Text("CodeBar"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: FractionalOffset.bottomLeft,
            stops: const [0.1, 0.2, 0.5],
            colors: [
              Colors.cyan[300]!,
              Colors.cyan[200]!,
              Colors.cyan[50]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(
                  "@96Azul",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.indigo[900],
                  ),
                ),
                subtitle: const Text(
                  "El valor del scan es: ",
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                _value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: _escanercode,
        child: const Icon(Icons.settings_overscan_sharp),
      ),
    );
  }
}
