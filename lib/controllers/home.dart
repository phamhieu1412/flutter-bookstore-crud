import 'package:bookstore_crud/db/virtual_db.dart';
import 'package:bookstore_crud/repositories/book.dart';
import 'package:bookstore_crud/models/book.dart';

class HomeController {
  BookRepository _bookRepo = BookRepository(VirtualDb());

  Future<List<Book>> getAllBooks() {
    return _bookRepo.getAll();
  }

  Future<void> addBook(Book book) {
    return _bookRepo.insert(book);
  }

  Future<void> removeBook(int id) {
    return _bookRepo.delete(id);
  }
}
