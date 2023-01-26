import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Constants/my_date_utils.dart';
import '../Models/message.dart';


class MessageCard extends StatefulWidget {
  final Message message;
  MessageCard({key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.uid == widget.message.senderId
        ? _greenMessage()
        : _blueMessage();
  }

  //sender or another user
  Widget _blueMessage() {
    // Timestamp t = widget.message.time as Timestamp;
    //           DateTime d = t.toDate();
    //           String hour = d.hour.toString();
    //           String mint = d.minute.toString();
    //           String date = d.day.toString() + "/" + d.month.toString();
    //           if (hour.length == 1) hour = "0" + hour;
    //           if (mint.length == 1) mint = "0" + mint;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Align(
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              // side: const BorderSide(color: Colors.purple),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              ),
            ),
            child: ListTile(
              title: Text(
                widget.message.username,
                style: const TextStyle(fontSize: 15),
              ),
              subtitle: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                     widget.message.message,
                      softWrap: true,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    width: 60,
                    alignment: Alignment.bottomRight,
                    child: Text(MyDatUtil.getFormattedTime(context: context, time: widget.message.time),style: TextStyle(fontSize: 12),maxLines: 1,),

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //our or user message
  Widget _greenMessage() {
    // Timestamp t = qs['time'];
              // DateTime d = t.toDate();
              // String hour = d.hour.toString();
              // String mint = d.minute.toString();
              // String date = d.day.toString() + "/" + d.month.toString();
              // if (hour.length == 1) hour = "0" + hour;
              // if (mint.length == 1) mint = "0" + mint;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Align(
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              // side: const BorderSide(color: Colors.purple),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              ),
            ),
            child: ListTile(
              title: Text(
                widget.message.username,
                style: const TextStyle(fontSize: 15),
              ),
              subtitle: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.message.message,
                      softWrap: true,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    width: 60,
                    alignment: Alignment.bottomRight,
                    child: Text(MyDatUtil.getFormattedTime(context: context, time: widget.message.time),maxLines: 1,style: TextStyle(fontSize: 12),),
                    // child: Column(
                    //   children: [
                    //     Text(hour + ":" + mint),
                    //     Text(date),
                    //   ],
                    // ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}