import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/Model/ContactModel.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {

    List<ContactModel> contacts = [
      ContactModel(name: "Camarade Antoine", status: "A full stack developer"),
      ContactModel(name: "Camarade Thibault", status: "A full stack developer"),
      ContactModel(name: "Camarade Selin", status: "A full stack developer"),
      ContactModel(name: "Camarade Eliseo", status: "A full stack developer"),
      ContactModel(name: "Camarade Jérémie", status: "A full stack chef de projet"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Select Contact",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
            ),
            Text(
              "256 contacts",
              style: TextStyle(
                  fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 26)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("Invite a friend"), value: "Invite a friend", ),
                PopupMenuItem(child: Text("Contacts"), value: "Contacts", ),
                PopupMenuItem(child: Text("Refresh"), value: "Refresh", ),
                PopupMenuItem(child: Text("Help"), value: "Help", ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2 ,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ButtonCard(icon: Icons.group, name: "New group");
            }
            else if (index == 1) {
              return ButtonCard(icon: Icons.person_add, name: "New contact");
            }
            else {
              return ContactCard(
                contact: contacts[index - 2],
              );
            }
          })
    );
  }
}
