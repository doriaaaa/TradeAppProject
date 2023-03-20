import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/models/comment.dart';
import '../provider/comment_provider.dart';

class discussionPage extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  final int threadId;
  final int likes;
  final int views;
  final String createdAt;

  const discussionPage({
    Key? key,
    required this.title,
    required this.author,
    required this.content,
    required this.threadId,
    required this.likes,
    required this.views,
    required this.createdAt
  }) : super(key: key);

  @override
  State<discussionPage> createState() => _discussionPageState();
}

class _discussionPageState extends State<discussionPage> {
  final _commentPageKey = GlobalKey<_discussionPageState>();
  List<Widget> displayItemList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _buildDisplayItemList();
  }

  void _buildDisplayItemList() async {
    List<Comment> comments = Provider.of<CommentProvider>(context, listen: false).comments;
    // List<Comment> comments = context.watch<CommentProvider>().comments;
    print('**************************************');
    print('comments.length: ${comments.length}');
    for (int i=0; i<comments.length; i++) {
      String body = comments[i].body; // access the body of the first comment in the list
      String username = comments[i].username;
      String date = comments[i].date;
      print('body_$i: $body');
      print('username_$i: $username');
      print('date_$i: $date');
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.thread);

    String title = widget.title;
    String timestamp = widget.createdAt;

    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    // thread content always display above
    final threadContentDisplayBox = Container(
      // height: 30.h,
      margin: EdgeInsets.fromLTRB(7.w, 2.h, 7.w, 2.h),
      // decoration: BoxDecoration(border: Border.all(color:const Color(0xFFFF9000))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 10.w,
              height: 10.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/avatar.jpg'), //dummy image
                  fit: BoxFit.scaleDown
                )
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              widget.author,
              style: TextStyle(fontSize: 12.sp),
            ),
            const Spacer(),
            Text(timestamp.substring(0, timestamp.indexOf('T')))
          ]),
          Text(widget.content),
          SizedBox(height: 2.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              const Icon(Icons.thumb_up_alt_outlined),
              SizedBox(width: 4.w),
              const Icon(Icons.thumb_down_alt_outlined),
            ],
          ),
        ],
      )
    );

    return WillPopScope(
      onWillPop: () async {
        Provider.of<CommentProvider>(context, listen: false).clearComments();
        return true;
      },
      child: Scaffold(
        key: _commentPageKey,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () { 
              Provider.of<CommentProvider>(context, listen: false).clearComments();
              Navigator.pop(context);
            },
            icon: const Icon( Icons.arrow_back_outlined ),
          ),
          flexibleSpace: const Image( image: AssetImage('assets/book_title.jpg'), fit: BoxFit.cover),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: FooterLayout(
            footer: const KeyboardAttachableFooter(),
            child:Scrollbar(
              thumbVisibility: true,
              controller: scollBarController,
              child: ListView(
                shrinkWrap: true,
                controller: scollBarController,
                // padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                children: <Widget>[
                  threadContentDisplayBox,
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 1,
                  ),
                  SizedBox(height: 2.h),
                ]
                // display comments
              ),
            )
          ),
        )
      )
    );
  }
}

class KeyboardAttachableFooter extends StatelessWidget {
  const KeyboardAttachableFooter({super.key});

  @override
  Widget build(BuildContext context) => KeyboardAttachable(
    child: Container(
      padding: EdgeInsets.all(5.w),
      child: Container(
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Tap me!",
            filled: true,
            border: OutlineInputBorder(),
          ),
        )
      )
      // TODO: add custom buttons
      ,
    ),
  );
}