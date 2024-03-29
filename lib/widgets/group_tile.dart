import 'package:convo_connect/pages/chat_page.dart';
import 'package:convo_connect/shared/constants.dart';
import 'package:convo_connect/widgets/widgets.dart';
import 'package:flutter/material.dart';
class GroupTile extends StatefulWidget {
  final String username;
  final String groupId;
  final String groupName;
  const GroupTile({super.key, required this.username, required this.groupId, required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(
          groupId: widget.groupId,
          groupName: widget.groupName,
          userName: widget.username,
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Constants.primaryColor,
            child: Text(
              widget.groupName.substring(0,1).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Join the conversation as ${widget.username}',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
