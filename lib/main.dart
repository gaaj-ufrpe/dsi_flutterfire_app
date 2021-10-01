import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const errorTitleStyle = TextStyle(color: Colors.yellow, fontSize: 20.0);
const errorDescStyle = TextStyle(
    color: Colors.yellow, fontStyle: FontStyle.italic, fontSize: 16.0);
const exceptionTitleStyle = TextStyle(color: Colors.yellow, fontSize: 20.0);
const exceptionDescStyle =
    TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 16.0);
const textTitleStyle = TextStyle(fontSize: 20.0);
const textDescStyle = TextStyle(fontSize: 16.0);

Widget _buildLoading() {
  return Center(
    child: Wrap(
      alignment: WrapAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(width: 10),
        Text('Loading...', style: textTitleStyle),
      ],
    ),
  );
}

///LEIA:
///https://firebase.google.com/docs/flutter/setup?platform=android
///
///1) Para saber o nome do app, abra o arquivo 'android/app/build.gradle'
/// e procure a propriedade 'applicationId'. Por padrão o nome é:
/// [pacote completo].[nome do projeto]
/// Ex.: br.ufrpe.gaaj.dsi_flutterfire_app
///
///2) No Flutter Console, na página de "Visão Geral do Projeto", abaixo do nome do
/// projeto, há um botão "+Adicionar app". É nele que se deve clicar para liberar
/// o acesso do app ao firebase.
///
///3) Copiar o arquivo gerado para 'android/app'
///
///4) Ajustar o arquivo 'android/build.gradle' conforme orientação do Console do Firebase;
///
///5) Ajustar o arquivo 'android/app/build.gradle' conforme orientação do Console do Firebase.
///Tenha atenção para acessar a opção Java ou Kotlin conforme a linguagem utilizada no projeto.
///
///6) A aba de problemas do AndroidStudio, pode acusar alguma incompatibilidade de
/// versões do Kotlin ou outra lib. Faça os ajustes recomendados.
/// Ex.: neste projeto foi necessário alterar a propriedade 'ext.kotlin_version'
/// para a versão '1.5.31' no arquivo 'android/build.gradle'
///
///7) Acesse https://firebase.flutter.dev/ procure a lib 'firebase_core' e
///Acesse a pagina 'Installing', copie o código indicado para ser adicionado no
///pubspec.yaml e cole lá. Atenção para usar as últimas versões.
///Os tutoriais da internet geralmente utilizam versões mais antigas.
///Faça a mesma coisa para o plugin 'cloud_firestore'
///(No tutorial do vídeo abaixo, utiliza-se o Firebase Realtime e nã
///o o Firestore).
///
///
///DÚVIDAS? VEJA:
///https://www.youtube.com/watch?v=EXp0gq9kGxI
///
/// ADICIONAL:
/// https://firebase.flutter.dev/docs/firestore/usage/
/// https://medium.com/firebase-tips-tricks/how-to-use-cloud-firestore-in-flutter-9ea80593ca40
///
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyFirebaseApp());
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildAppError(snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        return _buildLoading();
      },
    );
  }

  Directionality _buildAppError(Object? error) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Wrap(
          children: [
            const Text('Error:', style: errorTitleStyle),
            Text('$error', style: errorDescStyle),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  CollectionReference<Map<String, dynamic>> get contadores =>
      FirebaseFirestore.instance.collection('contadores');

  //O método 'doc()' deve receber o id do documento que está no Firebase.
  DocumentReference<Map<String, dynamic>> get docRef =>
      contadores.doc('OqzaUV6COKypNVufZz9L');

  void _incrementCounter() async {
    DocumentSnapshot docSnap = await docRef.get();
    int counter = docSnap.get('valor');
    counter++;
    docRef.set(
      {'valor': counter},
      SetOptions(merge: true),
    );
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
            'You have pushed the button this many times:',
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
