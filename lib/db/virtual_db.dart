import 'dart:math';

class VirtualDb {
  // => static: Biến tĩnh, cấp phát bộ nhớ 1 lần sử dụng trong cả app
  // => thông thường mọi biến / hàm sẽ là public, nếu muoosn private thì thêm _ truocws tên. vd items: là biến public, _items: là biến private
  List<Map<String, dynamic>> _items = [];
  static final VirtualDb _db = VirtualDb._privateConstructor();

  VirtualDb._privateConstructor();

  // => factory: tạo ra 1 constructor đặc biệt, khi sử dụng constructor này để tạo đối tượng nó sẽ không tạo ra một đối tượng mới nếu nó thấy đã có một đối tượng có sẵn rồi
  factory VirtualDb() {
    return _db;
  }

  Future<void> insert(Map<String, dynamic> item) async {
    item['id'] = Random().nextInt(1000);
    _items.add(item);
  }

  Future<void> remove(int id) async {
    _items.removeWhere((i) => i['id'] == id);
  }

  Future<void> update(Map<String, dynamic> newItem) async {
    int i = _items.indexWhere((i) => i['id'] == newItem['id']);
    _items[i] = newItem;
  }

  Future<Map<String, dynamic>?> findItem(int id) async {
    return _items.firstWhere((i) => i['id'] == id);
  }

  Future<List<Map<String, dynamic>>> list() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _items;
  }
}
