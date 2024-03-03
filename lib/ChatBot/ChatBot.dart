import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tsbridgedu/ChatBot/APIKEY.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  User? user;
  late ChatUser _currentUser;
  List<ChatMessage> _messages = [];
  List<ChatUser> _typingUsers = <ChatUser>[];
  final ChatUser _gptUser = ChatUser(id: '2', firstName: 'T',lastName: 'S');
  final _openAi = OpenAI.instance.build(
    token: OPEN_AI_KEY,
    baseOption: HttpSetup(receiveTimeout: Duration(seconds: 5)),
    enableLog: true,
  );

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _currentUser = ChatUser(id: user!.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Helper Bot"),
      ),
      body: DashChat(
        typingUsers: _typingUsers,
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Colors.greenAccent,
          textColor: Colors.white,
        ),
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptUser);
    });

    List<Messages> _messageHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();

    final _request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messageHistory,
      maxToken: 100,
    );

    try {
      final response = await _openAi.onChatCompletion(request: _request);
      for (var element in response!.choices) {
        if (element.message != null) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                user: _gptUser,
                createdAt: DateTime.now(),
                text: element.message!.content,
              ),
            );
          });
        }
      }
    } catch (e) {
      print("Error: $e");
      // Handle error
    }

    setState(() {
      _typingUsers.remove(_gptUser);
    });
  }
}
