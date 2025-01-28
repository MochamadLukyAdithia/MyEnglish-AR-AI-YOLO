import 'package:flutter/material.dart';

class AiConversationScreen extends StatefulWidget {
  const AiConversationScreen({super.key});

  @override
  State<AiConversationScreen> createState() => _AiConversationScreenState();
}

class _AiConversationScreenState extends State<AiConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Ini Ai Conversation"),
      ),
    );
  }
}
