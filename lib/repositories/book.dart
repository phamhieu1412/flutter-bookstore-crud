import 'package:bookstore_crud/db/virtual_db.dart';
import 'package:bookstore_crud/repositories/book_interface.dart';
import 'package:bookstore_crud/models/book.dart';

class BookRepository implements IBookRepository {
  final VirtualDb _db;

  BookRepository(this._db);

  @override
  Future<List<Book>> getAll() async {
    var items = await _db.list();
    return items.map((i) => Book.fromMap(i)).toList();
  }

  @override
  Future<Book?> findItem(int id) async {
    var item = await _db.findItem(id);
    return item != null ? Book.fromMap(item) : null;
  }

  // => toMap
  @override
  Future<void> insert(Book book) async {
    await _db.insert(book.toMap());
  }
  // => insert: thêm phần tử,
  // => insert(0, 10): có thể thêm vào vị trí 0 giá trị = 10

  @override
  Future<void> update(Book book) async {
    await _db.update(book.toMap());
  }

  @override
  Future<void> delete(int id) async {
    await _db.remove(id);
  }
  // => remove: xoa theo giá trị truyền vào
  // => removeAt: xoá theo vị trí truyền vào
  // => removeRange(0, 2): xoá theo vị trí từ 0 đến 2
}
