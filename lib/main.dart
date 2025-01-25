import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duo_clone/screens/assesment/screen3.dart';
import 'package:duo_clone/screens/assesment/splah_screen.dart';
import 'package:duo_clone/screens/assesment/tryscreen.dart';
import 'package:duo_clone/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return HomePage();
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Question Options')),
    //   body: FutureBuilder<DocumentSnapshot>(
    //     future: FirebaseFirestore.instance
    //         .collection('questions')
    //         .doc('question1')
    //         .get(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //       if (!snapshot.hasData || !snapshot.data!.exists) {
    //         return const Center(child: Text('No Data Found'));
    //       }

    //       // Mendapatkan data dari dokumen
    //       final data = snapshot.data!.data() as Map<String, dynamic>;
    //       final options = data['options'] as List<dynamic>;

    //       return ListView.builder(
    //         itemCount: options.length,
    //         itemBuilder: (context, index) {
    //           final option = options[index];
    //           return Card(
    //             child: ListTile(
    //               leading: Image.network(option['image'], fit: BoxFit.cover,),
    //               title: Text(option['text']),
    //               subtitle: Text(
    //                 'Is Correct: ${option['isCorrect']}',
    //                 style: TextStyle(
    //                   color: option['isCorrect'] ? Colors.green : Colors.red,
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
