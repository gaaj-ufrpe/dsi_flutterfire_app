
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const errorTitleStyle = TextStyle(color: Color.fromARGB(255, 255, 59, 59), fontSize: 20.0);
const errorDescStyle = TextStyle(
    color: Color.fromARGB(255, 255, 59, 59), fontStyle: FontStyle.italic, fontSize: 16.0);
const exceptionTitleStyle = TextStyle(color: Color.fromARGB(255, 255, 59, 59), fontSize: 20.0);
const exceptionDescStyle =
    TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 16.0);
const textTitleStyle = TextStyle(fontSize: 20.0);
const textDescStyle = TextStyle(fontSize: 16.0);

Widget _buildLoading() => Center(
  child: Wrap(
    alignment: WrapAlignment.center,
    children: const [
      CircularProgressIndicator(),
      SizedBox(width: 10),
      Text('Loading...', style: textTitleStyle),
    ],
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DSI Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DocumentReference<Map<String, dynamic>> docRef;

  @override
  void initState() {
    super.initState();
    CollectionReference<Map<String, dynamic>> contadores = 
      FirebaseFirestore.instance.collection('contadores');
    docRef = contadores.doc('OqzaUV6COKypNVufZz9L');
  }

  void _incrementCounter() async {
    DocumentSnapshot docSnap = await docRef.get();
    int counter = docSnap.get('valor');
    docRef.set({'valor': counter+1});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildCounter(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildCounter() {
    return FutureBuilder(
      future: docRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildCounterError();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          DocumentSnapshot<Map<String, dynamic>> docSnap =
              snapshot.data! as DocumentSnapshot<Map<String, dynamic>>;
          int counter = docSnap.get('valor');
          return _buildCounterDone(counter);
        }
        return _buildLoading();
      },
    );
  }

  Center _buildCounterDone(int counter) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Contador:',
            style: textDescStyle,
          ),
          Text(
            '$counter',
            style: textTitleStyle,
          ),
        ],
      ),
    );
  }

  Center _buildCounterError() {
    return const Center(
      child: Text(
        'Erro ao carregar o contador.',
        style: errorTitleStyle,
      ),
    );
  }
}
