import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duo_clone/screens/assesment/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class ScreenTry extends StatefulWidget {
  const ScreenTry({super.key});

  @override
  ScreenTryState createState() => ScreenTryState();
}

class ScreenTryState extends State<ScreenTry> {
  final FlutterTts flutterTts = FlutterTts();
  final player = AudioPlayer();

  String questionText = 'The Food';
  List<Map<String, dynamic>> options = [];
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  @override
  void dispose() {
    flutterTts.stop();
    player.dispose();
    super.dispose();
  }

  void _speak(String text) async {
    try {
      await flutterTts.setLanguage('en-US');
      await flutterTts.speak(text);
    } catch (e) {
      print('Error speaking text: $e');
    }
  }

  void _handleSelection(String text) {
    setState(() {
      selectedOption = text;
    });
  }

  void _checkAnswer() {
    final option = options.firstWhere(
      (option) => option['text'] == selectedOption,
      orElse: () => {},
    );

    bool isCorrect = option['isCorrect'] == true;

    _playSoundAndShowAnimation(context, isCorrect);
  }

  void _playSoundAndShowAnimation(BuildContext context, bool isCorrect) async {
    try {
      String soundAsset =
          isCorrect ? 'assets/sound/success.mp3' : 'assets/sound/failure.mp3';
      await player.setAsset(soundAsset);
      await player.play();

      String animationType = isCorrect ? 'success' : 'failure';
      _showBottomSheetWithAnimation(context, animationType, isCorrect);
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _showBottomSheetWithAnimation(
      BuildContext context, String animationType, bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    child: Lottie.asset(animationType == 'success'
                        ? 'assets/animation/correct.json'
                        : 'assets/animation/fail.json'),
                  ),
                  if (isCorrect) ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ScreenTwo();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'LANJUTKAN',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ] else ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to next screen if needed.
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'ULANGI',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ]
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _fetchQuestion() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('questions')
          .doc('question1')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          List<dynamic> fetchedOptions = data['options'] ?? [];

          setState(() {
            options = fetchedOptions
                .map((option) => {
                      'text': option['text'],
                      'image': option['image'],
                      'isCorrect': option['isCorrect'],
                    })
                .toList();
          });
        }
      }
    } catch (e) {
      print('Error fetching question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.blueGrey, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const SizedBox(
          height: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: LinearProgressIndicator(
              value: 0.25,
              backgroundColor: Colors.blueGrey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.volume_up,
                      color: Colors.blueGrey, size: 30),
                  onPressed: () => _speak(questionText),
                ),
                Expanded(
                  child: Text(
                    questionText,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Select the correct image',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  String optionText = options[index]['text'];
                  String imageUrl = options[index]['image'];

                  return GestureDetector(
                    onTap: () {
                      _handleSelection(optionText);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedOption == optionText
                              ? Colors.green
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              imageUrl: imageUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Text(
                          //   optionText,
                          //   style: const TextStyle(
                          //     color: Colors.blueGrey,
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 90.0),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'CHECK',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
