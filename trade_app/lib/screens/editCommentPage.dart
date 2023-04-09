import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/comment/commentService.dart';
import '../provider/comment_provider.dart';

class editCommentPage extends StatefulWidget {
  // fetch things from provider
  final int comment_id;
  final int thread_id;

  const editCommentPage({
    Key? key, 
    required this.thread_id, 
    required this.comment_id,
  }) : super(key: key);

  @override
  State<editCommentPage> createState() => _editCommentPageState();
}

class _editCommentPageState extends State<editCommentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contentInputFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final commentQuery = Provider.of<CommentProvider>(context, listen: false).comments[widget.comment_id - 1];
    contentInputFieldController = TextEditingController(text: commentQuery.body);
  }

  @override
  Widget build(BuildContext context) {
    final commentQuery = Provider.of<CommentProvider>(context, listen: false).comments[widget.comment_id - 1];
    // print(commentQuery.body);
    final contentInputField = TextFormField(
      maxLines: 5,
      textInputAction: TextInputAction.done,
      controller: contentInputFieldController,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Content cannot be null!';
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Description...',
        border: InputBorder.none,
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Comment"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  commentService().editComment(
                    context: context,
                    comment_id: commentQuery.comment_id,
                    thread_id: commentQuery.thread_id,
                    body: contentInputFieldController.text,
                  ).then((value) => Navigator.pop(context, true));
                }
              },
              icon: const Icon(Icons.check),
            )
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/book_title.jpg'),
            fit: BoxFit.cover
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: FooterLayout(
            footer: const KeyboardAttachableFooter(),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/default.jpg'),
                            fit: BoxFit.scaleDown
                          )
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              commentQuery.username,
                              style: TextStyle(fontSize: 12.sp)
                            ),
                            SizedBox(height: 1.0.h),
                            Text(
                              commentQuery.date.substring(0, commentQuery.date.indexOf('T')),
                              style: TextStyle(fontSize: 8.sp)
                            )
                          ]
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: 1.h),
                  contentInputField
                ],
              )
            ),
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
      child: Container()
        // TODO: add custom buttons
        // const TextField(
        //   decoration: InputDecoration(
        //     hintText: "Tap me!",
        //     filled: true,
        //     border: OutlineInputBorder(),
        //   ),
        // ),
    ),
  );
}
