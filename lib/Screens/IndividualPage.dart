import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter_svg/svg.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({ Key? key, required this.chatModel}) :super(key : key);
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
