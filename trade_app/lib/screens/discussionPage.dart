import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/constants/utils.dart';
import 'package:trade_app/models/comment.dart';
import 'package:trade_app/screens/editCommentPage.dart';
import 'package:trade_app/services/thread/threadService.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import '../provider/comment_provider.dart';
import '../provider/user_provider.dart';
import '../services/comment/commentService.dart';
import '../services/social/socialService.dart';

class discussionPage extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  final int threadId;
  final int likes;
  final int dislikes;
  final String createdAt;
  final bool userLiked;
  final bool userDisliked;

  const discussionPage({
    Key? key,
    required this.title,
    required this.author,
    required this.content,
    required this.threadId,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
    required this.userLiked,
    required this.userDisliked
  }) : super(key: key);

  @override
  State<discussionPage> createState() => _discussionPageState();
}

class _discussionPageState extends State<discussionPage> {
  List<Widget> displayCommentList = [];
  bool isLiked = false;
  bool isDisliked = false;
  bool isLoading = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.userLiked;
    isDisliked = widget.userDisliked;
    _buildDisplayItemList();
  }

  void _updateDisplayItemList() {
    setState(() {
      displayCommentList.clear();
    });
    _buildDisplayItemList();
  }

  void _buildDisplayItemList() async {
    List<Comment> comments = Provider.of<CommentProvider>(context, listen: false).comments;
    String user = Provider.of<UserProvider>(context, listen:false).user.name;
    String userProfilePic = Provider.of<UserProvider>(context, listen:false).user.profilePicture;
    String otherUserProfilePic = "";

    for (int i=0; i<comments.length; i++) {
      String body = comments[i].body; // access the body of the first comment in the list
      String username = comments[i].username;
      String date = comments[i].date;
      int userId = comments[i].userId;
      int thread_id = comments[i].thread_id;
      int comment_id = comments[i].comment_id;
      otherUserProfilePic = await socialService().loadUserProfilePictureFromUserId(
        context: context, 
        userId: userId
      );
      // print(userId);

      final commentContentDisplayBox = Container(
        margin: EdgeInsets.fromLTRB(7.w, 1.h, 7.w, 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: otherUserProfilePic != "" 
                        ? NetworkImage(otherUserProfilePic) 
                        : const AssetImage('assets/default.jpg') as ImageProvider,
                        fit: BoxFit.scaleDown
                      )
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text( username, style: TextStyle(fontSize: 12.sp)),
                            onTap: () {},
                          ),
                          Container(
                            child: username == user
                              ? GestureDetector(
                                onTap:() async {
                                  print("comment_id: $comment_id");
                                  final update = await Navigator.push(context, 
                                     MaterialPageRoute( 
                                      builder: (context) => editCommentPage(
                                        thread_id: thread_id,
                                        comment_id: comment_id,
                                      )
                                    )
                                  );
                                  if(update) {
                                    setState(() {
                                      _updateDisplayItemList();
                                    });
                                  }
                                },
                                child: Icon(
                                  CupertinoIcons.pencil,
                                  color: Colors.lightBlue[800],
                                ),
                              )
                              : Container()
                          )
                        ]
                      ),
                      // Text( username, style: TextStyle(fontSize: 12.sp)),
                      SizedBox(height:1.0.h),
                      Text( date.substring(0, date.indexOf('T')), style: TextStyle(fontSize: 8.sp))
                    ]
                  ),
                )
              ] 
            ),
            Text(body),
          ],
        )
      );
      displayCommentList.add(commentContentDisplayBox);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String timestamp = widget.createdAt;
    final commentController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String userProfilePic = context.watch<UserProvider>().user.profilePicture;
    String user = context.watch<UserProvider>().user.name;
    
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    // thread content always display above
    final threadContentDisplayBox = Container(
      margin: EdgeInsets.fromLTRB(7.w, 1.h, 7.w, 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: widget.author == user 
                      ? NetworkImage(userProfilePic)
                      : const AssetImage('assets/default.jpg') as ImageProvider,
                      fit: BoxFit.scaleDown
                    )
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( widget.author, style: TextStyle(fontSize: 12.sp)),
                    SizedBox(height:1.5.h),
                    Text( timestamp.substring(0, timestamp.indexOf('T')), style: TextStyle(fontSize: 8.sp))
                  ]
                ),
              ),
              const Spacer(),
            ] 
          ),
          Text(widget.content),
          SizedBox(height: 2.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked == true || isDisliked == true) {
                      showSnackBar(context, "You have liked / disliked this thread already.");
                      return; // do nothing if already liked/disliked
                    }
                    if (isLiked == false && isDisliked == false) {
                      isLiked = true;
                      threadService().userLikedThread(context: context, threadId: widget.threadId);
                    }
                  });
                },
                child: Icon(
                  isLiked == true ? Icons.thumb_up_rounded : Icons.thumb_up_alt_outlined,
                  color: isLiked == true ? Colors.greenAccent : null,
                )
              ),
              SizedBox(width: 5.w),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked == true || isDisliked == true) {
                      showSnackBar(context, "You have liked / disliked this thread already.");
                      return; // do nothing if already liked/disliked
                    }
                    if (isLiked == false && isDisliked == false) {
                      isDisliked = true;
                      threadService().userDislikedThread(context: context, threadId: widget.threadId);
                    }
                  });
                },
                child: Icon(
                  isDisliked == true ? Icons.thumb_down_rounded : Icons.thumb_down_alt_outlined,
                  color: isDisliked == true ? Colors.redAccent : null,
                )
              ),
              // const Icon(Icons.thumb_down_alt_outlined),
            ],
          ),
        ],
      )
    );

    List<Widget> displayItemList = [
      threadContentDisplayBox,
      Divider( color: Colors.grey.withOpacity(0.5), thickness: 2),
    ];

    List<Widget> threadCommentList = displayItemList + displayCommentList;
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
        // FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<CommentProvider>(context, listen: false).clearComments();
          return true;
        },
        child: Scaffold(
          appBar: ReusableWidgets.persistentAppBar(
            title,
            leading: IconButton(
              onPressed: () { 
                Provider.of<CommentProvider>(context, listen: false).clearComments();
                Navigator.pop(context);
              },
              icon: const Icon( Icons.arrow_back_outlined ),
            ),
          ),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: FooterLayout(
              footer: KeyboardAttachable(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    padding: EdgeInsets.all(2.w),
                    child: TextFormField(
                      autocorrect: true,
                      controller: commentController,
                      minLines: 1,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'You need to input at least 1 character';
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Add a comment...",
                        contentPadding: EdgeInsets.only(left: 5.w, top: 1.h, bottom: 1.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              commentService().createComment(
                                context: context,
                                body: commentController.text,
                                threadId: widget.threadId
                              ).then((value) => _updateDisplayItemList());
                            }
                          },
                        ),
                      ),
                    )
                  ),
              ),
              ),
              child: isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : Scrollbar(
                  thumbVisibility: true,
                  controller: scrollBarController,
                  child: ListView(
                    shrinkWrap: true,
                    controller: scrollBarController,
                    children: threadCommentList
                  ),
              )
            ),
          ),
        )
      )
    );
  }
}