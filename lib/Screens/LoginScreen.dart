import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/Homescreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ChatModel? sourceContact;

  List<ChatModel> contacts = [
    ChatModel(
        name: "Dev Stack",
        isGroup: false,
        currentMessage: "Hi everyone",
        time: "4:00",
        icon: "person.svg",
        status: "A full stack developer",
        id: 1
    ),
    ChatModel(
        name: "Kishor",
        isGroup: false,
        currentMessage: "Hi kiki",
        time: "10:00",
        icon: "person.svg",
        status: "A full stack developer",
        id: 2
    ),
    ChatModel(
        name: "Collins",
        isGroup: false,
        currentMessage: "Hi dev Stack",
        time: "10:00",
        icon: "person.svg",
        status: "A full stack developer",
        id: 3
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) => InkWell(
            child: ButtonCard(
              name: contacts[index].name,
              icon: Icons.person,
            ),
              onTap: () {
                ChatModel sourceContact = contacts.removeAt(index);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(
                    builder: (builder) =>
                        Homescreen(
                            chatModels: contacts,
                            sourceChat: sourceContact,)));
              },

            )

      ),
    );
  }
}
