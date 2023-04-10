import 'dart:async';
import 'dart:convert';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../services/book/bookService.dart';
import '../widgets/reusableWidget.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int page = 0;
  final ScrollController _sc = ScrollController(initialScrollOffset: 0.0);
  List bookList = [];
  String _bookListResponse = "";
  bool endOfListAppended = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar("Trending Books"),
      // implement trending list
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2.w),
            child: const Text(
              'Weekly Recommendation',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: _buildTrendingBookList(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(4.0.w),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: const Color(0xFF535353),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
                ),
                child: Row(
                  children: const [
                    Icon( color: Color(0xFFbabcbe), Icons.search),
                    Text( "Seach for a book", style: TextStyle(color: Color(0xFFBabcbe)))
                  ]
                ),
                onPressed: () {
                  showSearch(
                    context: context, 
                    delegate: CustomSearchDelegate()
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingBookList() {
    return Stack(
      children: [
        ListView.separated(
          controller: _sc,
          itemCount: bookList.length,
          separatorBuilder: (context, index) { return const Divider(); },
          itemBuilder: (context, index) {
            Map book = jsonDecode(bookList[index]);
            return ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 30.h,
                  maxWidth: 10.w
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: book['book_image'] != null
                  ? Image.network(book['book_image'])
                  : const Icon(Icons.image_not_supported_outlined)
                )
              ),
              title: Text(StringUtils.capitalize(book['title'], allWords: true)),
              // user clicks the list tile will be redirected to see the summary of the book
              // trailing: 
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: isLoading
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Future<String> getBookListResponse() async {
    final String res = await bookService().trendingBookList();
    return res;
  }

  void _fetchBookList() async {
    _bookListResponse = await getBookListResponse();
    fetchBookList(page, _bookListResponse);
    _sc.addListener(() {
      if (_sc.position.pixels ==  _sc.position.maxScrollExtent) {
        fetchBookList(page, _bookListResponse);
        setState(() {
          isLoading = true;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  void fetchBookList(int index, String _bookListResponse) {
    // final String res = await bookService().trendingBookList();
    Map trendingBookList = jsonDecode(_bookListResponse);
    // Check if 'lists' is null or out of range
    if (trendingBookList['results']['lists'] == null || index >= trendingBookList['results']['lists'].length) {
      setState(() {
        if (!endOfListAppended) { // check if end of list has not been appended before
          bookList += ['{"title":"This is the end of list"}'];
          endOfListAppended = true; // mark that end of list has been appended
        }
      });
      return;
    }
    List books = []; // 5 suggestions in a list, each time load 5 books
    for (int i=0; i < trendingBookList['results']['lists'][index]['books'].length; i++) {
      // print("printing booklist $index");
      books.add(jsonEncode(trendingBookList['results']['lists'][index]['books'][i]));
    }
    setState(() {
      bookList += books;
      page++;
    });
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> seacrhTerms = [
    'Atomic Habits',
    'Cracking the Coding Interview, Fourth Edition Book 1',
    'The Last Wish',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var book in seacrhTerms) {
      if (book.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in seacrhTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
