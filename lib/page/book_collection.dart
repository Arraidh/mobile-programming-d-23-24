import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/book_database.dart';
import '../model/books.dart';
import '../page/edit_book.dart';
import '../page/book_detail.dart';
import '../widget/book_card_detail.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late List<Book> books;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBooks();
  }

  @override
  void dispose() {
    BooksDatabase.instance.close();

    super.dispose();
  }

  Future refreshBooks() async {
    setState(() => isLoading = true);

    books = await BooksDatabase.instance.readAllBooks();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Book Collections',
        style: TextStyle(fontSize: 24),
      ),
      actions: const [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: SingleChildScrollView(
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : books.isEmpty
            ? const Text(
          'No Books',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildBooks(),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue.shade300,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditBookPage()),
        );

        refreshBooks();
      },
    ),
  );
  Widget buildBooks() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        books.length,
            (index) {
          final book = books[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookDetailPage(bookId: book.id!),
                ));

                refreshBooks();
              },
              child: BookCardWidget(book: book, index: index),
            ),
          );
        },
      ));


}
