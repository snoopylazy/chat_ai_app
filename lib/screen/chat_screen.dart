import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot_app/model/message_model.dart';
import 'package:chat_bot_app/provider/msg_provider.dart';
// import 'package:chat_bot_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/util_helper.dart';

class ChatScreen extends StatefulWidget {
  String query;
  ChatScreen({super.key, required this.query});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatBoxController = TextEditingController();
  List<MessageModel> listMsg = [];

  /// Time format
  DateFormat dateFormat = DateFormat().add_jm();

  @override
  void initState() {
    super.initState();

    /// Send initial query when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MessageProvider>(context, listen: false)
          .sendMessage(message: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/robot.png", height: 30),
            Text.rich(
              TextSpan(
                text: "Chat",
                style: mTextStyle25(fontColor: Colors.white),
                children: [
                  TextSpan(
                    text: "bot",
                    style: mTextStyle25(fontColor: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade200.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(100)),
                child:
                    IconButton(icon: const Icon(Icons.face), onPressed: () {})),
          ),
        ],
      ),
      body: Column(
        children: [
          /// ---------------- Chat List ----------------------- ///
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, child) {
                listMsg = provider.listMessage;
                return ListView.builder(
                  reverse: true,
                  itemCount: listMsg.length,
                  itemBuilder: (context, index) {
                    return listMsg[index].sendId == 0
                        ? userChatBox(listMsg[index])
                        : botChatBox(listMsg[index], index); //
                  },
                );
              },
            ),
          ),

          /// Chat box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: chatBoxController,
              style: mTextStyle18(fontColor: Colors.white70),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mic, color: Colors.white),
                suffixIcon: InkWell(
                  onTap: () {
                    Provider.of<MessageProvider>(context, listen: false)
                        .sendMessage(message: chatBoxController.text);
                    setState(() {
                      chatBoxController.clear();
                    });
                  },
                  child: const Icon(Icons.send, color: Colors.orange),
                ),
                hintText: "Write a question!",
                hintStyle: mTextStyle18(fontColor: Colors.white38),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Right Side - User Chat Box
  Widget userChatBox(MessageModel msgModel) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt!)));
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomLeft: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msgModel.msg!,
              style: mTextStyle18(fontColor: Colors.white70),
            ),
            Text(
              time,
              style: mTextStyle11(
                fontColor: Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Left Side - Bot Chat Box
  Widget botChatBox(MessageModel msgModel, int index) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt!)));
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomRight: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Bot Message
            msgModel.isRead!
                ? SelectableText(
                    msgModel.msg!,
                    style: mTextStyle18(fontColor: Colors.black87),
                  )
                : DefaultTextStyle(
                    style: mTextStyle18(fontColor: Colors.black87),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      displayFullTextOnTap: true,
                      isRepeatingAnimation: false,
                      onFinished: () {
                        context
                            .read<MessageProvider>()
                            .updateMessageRead(index);
                      },
                      animatedTexts: [
                        TypewriterAnimatedText(
                          msgModel.msg!,
                          textStyle: mTextStyle18(fontColor: Colors.black87),
                        ),
                      ],
                    ),
                  ),

            /// Timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/typing.png",
                      height: 30,
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: msgModel.msg!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Text copied to clipboard!",
                              style: mTextStyle18(fontColor: Colors.white70),
                            ),
                            backgroundColor: Colors.orange.withOpacity(0.8),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.copy_rounded,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: mTextStyle15(
                    fontColor: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
