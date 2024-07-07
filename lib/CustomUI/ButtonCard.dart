import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({ Key? key, required this.name, required this.icon}) :super(key : key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
        leading: CircleAvatar(
          radius: 23,
          child: Icon(icon,
          size: 23,
          color: Colors.white,),
          backgroundColor: Color(0XFF25D366),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),

    );
  }
}
