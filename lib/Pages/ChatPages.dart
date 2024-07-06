import 'package:chatapp/CustomUI/CustomCard.dart';
import 'package:chatapp/Screens/SelectContact.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';

    class ChatPage extends StatefulWidget {
      const ChatPage({super.key});
    
      @override
      State<ChatPage> createState() => _ChatPageState();
    }
    
    class _ChatPageState extends State<ChatPage> {

      List<ChatModel> chats = [
        ChatModel(
          name: "Dev Stack",
          isGroup: false,
          currentMessage: "Hi everyone",
          time: "4:00",
          icon: "person.svg"
        ),
        ChatModel(
            name: "Kishor",
            isGroup: false,
            currentMessage: "Hi kiki",
            time: "10:00",
            icon: "person.svg"
        ),
        ChatModel(
            name: "Collins",
            isGroup: false,
            currentMessage: "Hi dev Stack",
            time: "10:00",
            icon: "person.svg"
        ),
        ChatModel(
            name: "Dev Server Chat",
            isGroup: true,
            currentMessage: "Hi everyone",
            time: "10:00",
            icon: "groups.svg"
        ),
        ChatModel(
            name: "Balram Friends Stack",
            isGroup: true,
            currentMessage: "Hi everyone",
            time: "8:00",
            icon: "groups.svg"
        ),
      ];
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectContact()));
            },
            child: Icon(Icons.chat),
          ),
          body:ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => CustomCard(
                  chatModel: chats[index],))
        );
      }
    }
    