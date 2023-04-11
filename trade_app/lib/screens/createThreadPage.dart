import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/thread/threadService.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import '../constants/utils.dart';

class createThreadPage extends StatefulWidget {
  final String? title;

  const createThreadPage({Key? key, required this.title}) : super(key: key);
  static const String routeName = '/createNewThread';

  @override
  State<createThreadPage> createState() => _createThreadPageState();
}

class _createThreadPageState extends State<createThreadPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleInputFieldController = TextEditingController();
  TextEditingController contentInputFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleInputFieldController = 
      widget.title != null
      ? TextEditingController( text: "Discussion on ${widget.title}")
      : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final titleInputField = TextFormField(
      maxLines: null,
      textInputAction: TextInputAction.next,
      controller: titleInputFieldController,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You need to enter a title to create a new thread!';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Title',
      ),
    );

    final contentInputField = TextFormField(
      maxLines: null,
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
        appBar: ReusableWidgets.persistentAppBar(
          "New Post",
          actions: <Widget>[
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  threadService().createThread(
                    context: context,
                    title: titleInputFieldController.text,
                    content: contentInputFieldController.text
                  );
                } else {
                  showSnackBar(context, 'Missing title / description');
                }
              },
              icon: const Icon(Icons.check),
            )
          ],
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
                  SizedBox(height: 2.h),
                  titleInputField,
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
    child: Container(padding: EdgeInsets.all(5.w), child: Container()
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
