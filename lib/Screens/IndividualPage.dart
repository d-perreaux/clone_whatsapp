import 'dart:developer';

import 'package:chatapp/CustomUI/OwnMessageCard.dart';
import 'package:chatapp/CustomUI/ReplyCardMessage.dart';
import 'package:chatapp/Model/MessageModel.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage({ Key? key, required this.chatModel, required this.sourceChat}) :super(key : key);
  final ChatModel chatModel;
  final ChatModel sourceChat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  IO.Socket? socket;
  bool sendButton = false;
  List<MessageModel> messages = [];

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.1.21:5000", <String, dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket?.connect();
    socket?.onConnect((data) {
      print("Preuve");
      socket?.on("message", (data) {
        SetMessage("destination", data["message"]);
      });
    });
    socket?.emit("signing", widget.sourceChat.id);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    SetMessage("source", message);
    socket?.emit("message",
            {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void SetMessage(String type, String message) {

    MessageModel messageModel = MessageModel(message: message, type: type);

    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/whatsappbackground.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.arrow_back,
                      size: 24,),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg" ,
                      color: Colors.white,
                      height: 37,
                      width: 37,
                  ),
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chatModel.name, style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("Last seen today at 12:05", style: TextStyle(fontSize: 13),)
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(child: Text("View Contact"), value: "View Contact", ),
                    PopupMenuItem(child: Text("Media, links, and docs"), value: "Media, links, and docs", ),
                    PopupMenuItem(child: Text("What's app Web"), value: "What's app Web", ),
                    PopupMenuItem(child: Text("Search"), value: "Search", ),
                    PopupMenuItem(child: Text("Mute notifications"), value: "Mute notifications", ),
                    PopupMenuItem(child: Text("Wallpaper"), value: "Wallpaper", ),
                  ];
                },
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 140,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      if (messages[index].type == "source"){
                        return OwnMessageCard(message: messages[index].message);
                      } else {
                        return ReplyMessageCard(message: messages[index].message);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                              child: TextFormField(
                                controller: _controller,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines : 5,
                                minLines: 1,
                                onChanged: (value) {
                                  if(value.isNotEmpty) {
                                    setState(() {
                                      sendButton = true;
                                    });
                                  } else {
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  contentPadding: EdgeInsets.all(5),
                                  prefixIcon: IconButton(icon: Icon(Icons.emoji_emotions), onPressed: () {} ,),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(onPressed: () {} , icon: Icon(Icons.attach_file)),
                                      IconButton(onPressed: () {} , icon: Icon(Icons.camera_alt))
                                    ],
                                  )
                                )
                              ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 5),
                        child: CircleAvatar(
                          backgroundColor: Color(0XFF128C7E),
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                            sendButton ? Icons.send : Icons.mic,
                            color: Colors.white,), onPressed: () { 
                              if(sendButton) {
                                sendMessage(_controller.text, widget.sourceChat.id, widget.chatModel.id);
                                _controller.clear();
                              }
                          },),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
