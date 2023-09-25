import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bookstore_crud/controllers/home.dart';
import 'package:bookstore_crud/models/book.dart';

void main() {
  // => runApp: ham khoi dong app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Repo Book Store'),
          ),
          // Các kiểu body
          // =>
          // body: MyHomePage()),
          // =>
          // body: const Text(
          //   "hello world",
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     color: Colors.red,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // =>
          // body: Container(
          //   color: Colors.green,
          //   alignment: Alignment.bottomRight,
          //   margin: const EdgeInsets.all(30),
          //   child: const Text(
          //     "hello world",
          //     textAlign: TextAlign.right,
          //     style: TextStyle(
          //       color: Colors.red,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // =>
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.pink,
                transform: Matrix4.rotationX(3.14 / 4),
                child: const Text(
                  "hello world 1",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.yellow, width: 10)),
                child: const Text(
                  "hello world pink 50",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                // color: Colors.black12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    ),
                    const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 15,
                        spreadRadius: 1),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                      Colors.grey.shade400,
                      Colors.grey.shade500,
                    ],
                  ),
                ),
                child: const Text(
                  "hello world 2",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: const CircularProgressIndicator(),
              )
            ],
          )),
      // debugShowCheckedModeBanner: false, => bỏ ticker debug
    );
  }
}

class MyHomePage extends StatefulWidget {
  final HomeController _homeController = HomeController();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      _Form(widget._homeController, _refreshList),
      _BookTable(widget._homeController, _refreshList)
    ]);
  }
}

class _Form extends StatefulWidget {
  final HomeController _homeController;
  final VoidCallback _refreshList;

  _Form(this._homeController, this._refreshList);

  @override
  _FormState createState() => _FormState();
}

// => TextEditingController: text input trong RN
// => GlobalKey: là một key duy nhất trên toàn App. Nếu như ví cái App như là nước Việt Nam, thì GlobalKey giống như giấy căn cước (giấy CMND).
// Nhờ cái giấy căn cước này, mà ta có thể tìm ra chính cái Element đó trên cái app. Nhờ đó mà ta có thể truy cập vào Element đó để lấy các thông tin nó đang quản lý như State và Widget
// => FormState: Để thực hiện validate, ta cần gọi hàm validate của class FormState (Form cũng là một StatefulWidget và FormState là State của widget Form)
class _FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _yearFieldController = TextEditingController();

  // => dispose
  @override
  void dispose() {
    _titleFieldController.dispose();
    _yearFieldController.dispose();
    super.dispose();
  }

  // => BuildContext
  // => Container
  // => Form
  // => EdgeInsets
  // => Column
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleFieldController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter book title1';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _yearFieldController,
              decoration: const InputDecoration(
                labelText: 'Year',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
              ],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter book year';
                }
                return null;
              },
            ),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget._homeController.addBook(Book(
                        0,
                        _titleFieldController.text,
                        int.parse(_yearFieldController.text),
                      ));
                    }
                    _titleFieldController.clear();
                    _yearFieldController.clear();
                    widget._refreshList();
                  },
                  child: Text('Add Book'),
                )),
          ],
        ),
      ),
    );
  }
}

class _BookTable extends StatelessWidget {
  final HomeController _homeController;
  final VoidCallback _refreshList;

  _BookTable(this._homeController, this._refreshList);

  // => builder
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _homeController.getAllBooks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('Loading ...'));
        } else {
          return DataTable(
            columns: _createBookTableColumns(),
            rows: _createBookTableRows(snapshot.data ?? []),
          );
        }
      },
    );
  }

  List<DataColumn> _createBookTableColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Book')),
      const DataColumn(label: Text('Action')),
    ];
  }

  List<DataRow> _createBookTableRows(List<Book> books) {
    return books
        .map((book) => DataRow(cells: [
              DataCell(Text('#' + book.id.toString())),
              DataCell(Text('${book.title} (${book.year.toString()})')),
              DataCell(IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await _homeController.removeBook(book.id);
                  _refreshList();
                },
              ))
            ]))
        .toList();
  }
}

// ProductBox({Key key, this.name}) : super(key: key);
// final String name;