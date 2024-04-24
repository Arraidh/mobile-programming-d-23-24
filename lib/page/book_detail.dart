import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/book_database.dart';
import '../model/books.dart';
import '../page/edit_book.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  const BookDetailPage({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBook();
  }

  Future refreshBook() async {
    setState(() => isLoading = true);

    book = await BooksDatabase.instance.readBook(widget.bookId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Container(
            child:
              ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(book.image),

              ),
            ),

            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.shade200,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            book.title,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(book.createdTime),
            style: TextStyle(color: Colors.blue.shade900),
          ),
          const SizedBox(height: 8),
          Text(
            book.description,
            style:
            TextStyle(color: Colors.blue.shade900, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditBookPage(book: book),
        ));

        refreshBook();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await BooksDatabase.instance.delete(widget.bookId);

      Navigator.of(context).pop();
    },
  );
}
