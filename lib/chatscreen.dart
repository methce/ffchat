import 'package:ff_chat/chatmessage.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  void _handleSubmit(String text) {
    _chatController.clear();
    setState(() {
      //new
      _isComposing = false; //new
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    //new
    for (ChatMessage message in _messages) //new
      message.animationController.dispose(); //new
    super.dispose(); //new
  }

  Widget _chatEnvironment() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _chatController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmit,
                decoration:
                    new InputDecoration.collapsed(hintText: "Start typing ..."),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmit(_chatController.text) //modified
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("FFChat")),
      body: new Column(
        //modified
        children: <Widget>[
          //new
          new Flexible(
            //new
            child: new ListView.builder(
              //new
              padding: new EdgeInsets.all(8.0), //new
              reverse: true, //new
              itemBuilder: (_, int index) => _messages[index], //new
              itemCount: _messages.length, //new
            ), //new
          ), //new
          new Divider(height: 1.0), //new
          new Container(
            //new
            decoration:
                new BoxDecoration(color: Theme.of(context).cardColor), //new
            child: _chatEnvironment(), //modified
          ), //new
        ], //new
      ), //new
    );
//    return new Column(
//      children: <Widget>[
//        new Flexible(
//          child: ListView.builder(
//            padding: new EdgeInsets.all(8.0),
//            reverse: true,
//            itemBuilder: (_, int index) => _messages[index],
//            itemCount: _messages.length,
//          ),
//        ),
//        new Divider(
//          height: 1.0,
//        ),
//        new Container(
//          decoration: new BoxDecoration(
//            color: Theme.of(context).cardColor,
//          ),
//          child: _chatEnvironment(),
//        )
//      ],
//    );
  }
}
