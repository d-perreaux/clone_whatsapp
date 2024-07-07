import 'package:chatapp/CustomUI/CustomCard.dart';
import 'package:chatapp/Screens/SelectContact.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';

    class ChatPage extends StatefulWidget {
      const ChatPage({ Key? key, required this.chatModels}) :super(key : key);
      final List<ChatModel> chatModels;
    
      @override
      State<ChatPage> createState() => _ChatPageState();
    }
    
    class _ChatPageState extends State<ChatPage> {

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
              itemCount: widget.chatModels.length,
              itemBuilder: (context, index) => CustomCard(
                  chatModel: widget.chatModels[index],))
        );
      }
    }
    