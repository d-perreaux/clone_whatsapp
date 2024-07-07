import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Pages/ChatPages.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({ Key? key, required this.chatModels}) :super(key : key);
  final List<ChatModel> chatModels;


  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Whatsapp Clone"),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text("New group"), value: "New Group", ),
                  PopupMenuItem(child: Text("New broadcast"), value: "New broadcast", ),
                  PopupMenuItem(child: Text("What's app Web"), value: "What's app Web", ),
                  PopupMenuItem(child: Text("Starred messages"), value: "Starred messages", ),
                  PopupMenuItem(child: Text("Settings"), value: "Setting", ),
                ];
              },
              )
            ],
            bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.camera_alt),
                ),
                Tab(
                  text: "CHATS",
                ),
                Tab(
                  text: "STATUS"
                ),
                Tab(
                  text: "CALLS"
                )
              ],
            ),
          ),
      body: TabBarView(
        controller: _controller,
        children: [
          Text("camera"),
          ChatPage(chatModels: widget.chatModels,),
          Text("status"),
          Text("calls")
        ],

      ),
        );
  }
}
