import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';
void main(){
  Gemini.init(apiKey: "AIzaSyA8YyMv74OAP4sr8KbmKLu7cwdAFo6P590");
  runApp(Chatbot());
}
class Chatbot extends StatefulWidget {

  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage (),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String response= "How can i help you?";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Icon(Icons.message),
            SizedBox(width: 10,),
            Text("ChatBot"),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome to chat bot", style: TextStyle(fontSize: 25, color: Colors.pink),),
            Lottie.asset("assets/lottie/chat_bot.json"),
            Expanded(child: SingleChildScrollView(
              child: Text(
                response,
                ),

            ))
              ,Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      labelText: "Enter your message",
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                ElevatedButton(onPressed: (){
                  Gemini.instance.promptStream(parts: [
                    Part.text(textEditingController.text),
                  ]).listen((value) {
                    setState(() {
                      response = value!.output!;
                    });
                  });
                }, child: Icon(Icons.send))
              ],
            )

          ],
        ),
      ),
    );
  }
}