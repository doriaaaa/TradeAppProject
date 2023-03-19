import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/thread/threadService.dart';
import '../constants/utils.dart';

class createThreadPage extends StatefulWidget {
  const createThreadPage({Key? key}) : super(key: key);
  static const String routeName = '/createNewThread';

  @override
  State<createThreadPage> createState() => _createThreadPageState();
}

class _createThreadPageState extends State<createThreadPage> {
  final _formKey = GlobalKey<FormState>();
  final titleInputFieldController = TextEditingController();
  final contentInputFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final titleInputField = TextFormField(
      textInputAction: TextInputAction.next,
      controller: titleInputFieldController,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'You need to enter a title to create a new thread!';
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Title',
      ),
    );

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
    
    return Scaffold(
      appBar:AppBar(
        title: const Text("New Post"),
        centerTitle: true,
        actions: <Widget>[
          IconButton( 
            onPressed: () {
              if (_formKey.currentState!.validate()) { 
                threadService().createNewThread(
                  context: context,
                  title: titleInputFieldController.text, 
                  content: contentInputFieldController.text
                );
              } else {
                showSnackBar( context,'Missing title / description');
              }
            }, 
            icon: const Icon( Icons.check ),
          )
        ],
        leading: IconButton(
          onPressed: () { Navigator.pop(context);},
          icon: const Icon( Icons.arrow_back_outlined ),
        ),
        flexibleSpace: const Image( image: AssetImage('assets/book_title.jpg'), fit: BoxFit.cover),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
          child: FooterLayout(
            footer: KeyboardAttachableFooter(),
            child:Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                children: <Widget>[
                  SizedBox(height: 2.h),
                  titleInputField,
                  SizedBox(height: 1.h),
                  contentInputField
                ],
              )
            ) ,
          ),
      )
      // Form(
      //   key: _formKey,
      //   child: ListView(
      //     padding: EdgeInsets.only(left: 7.w, right: 7.w),
      //     children: <Widget>[
      //       SizedBox(height: 2.h),
      //       titleInputField,
      //       SizedBox(height: 1.h),
      //       contentInputField
      //     ],
      //   )
      // )
    );
  }
}

class KeyboardAttachableFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => KeyboardAttachable(
    backgroundColor: Colors.blue,
    child: Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Tap me!",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );
}