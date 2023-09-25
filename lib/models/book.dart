class Book {
  // => final & const giống nhau nhưng final thì k cần gán giá trị cho biến còn const thì bắt buộc phải gắn 
  // const vd: static const canThink = true; (bắt buộc có static + const)
  // nhung nếu final đã gán giá trị r thì k đc gán giá trị mới cho n nữa, giống const ở đây
  final int id;
  final String title;
  final int year;

  // => khoi tao doi tuong ~ constructor
  Book(this.id, this.title, this.year);

  // => Map: kiểu giống object với key:value như javascript
  // Map<int, String> map01 = {
  //   1: "Báo Flutter",
  //   2: "123456789"
  // };
  // => dynamic: kiểu dữ liệu có thể thay đổi, vd ban đầu là kiểu string khi dùng dynamic có thể gán giá trị là int, bool, ...
  // => var: giống dynamic nhưng nếu gán giá trị ban đầu với var thì những giá trị sau gán phải cùng kiểu với giá trị ban đầu
  // var a = 5 ==> sẽ gán được a =10 nhyungw k gán được a = "String". Nhưng kiểu dữ liệu dynamic thì làm được
  Book.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        year = data['year'];

  // => fromMap: Dùng để map các trường trong db với các thuộc tính đối tượng expense và tạo ra đối tượng expense mới
  // => toMap: Sử dụng để chuyển đổi đối tượng expense sang dart map mà xa hơn là sử dung để lập trình db
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
    };
  }
}


// enum Person {tit, hieu}
// Person.tit
// => get gia tri: Person.tit.name
// => so luong phan tu: Person.values.length
// => lay phan tu dau tien: Person.values[0] / Person.values.first
// => phan tu cuoi cung: Person.values[Person.values.length - 1] / Person.values.last
// => check rong: Person.values.isEmpty
// => check khong rong: Person.values.isNotEmpty
// => Person.values.forEach((name) {
//   print(name);
// });

// => as, is, is! : toán tử kiểm tra kiểu dữ liệu

// => var name = (check == null) ? 'Default' : check
// => var name = check ? 'Default'
// => ..
// vd: List <int> list = []; list.add(1); list.add(2);
// tương đương với: list..add(1)..add(2)