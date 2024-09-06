import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({super.key});

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("เพิ่มรายการใหม่"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "ชื่อหัวข้อ"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "รายละเอียด"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _myList.add({
                    'หัวข้อ': _titleController.text,
                    'รายละเอียด': _detailController.text
                  });
                });
                _titleController.clear();
                _detailController.clear();
                Navigator.pop(context);
              },
              child: const Text("บันทึก"),
            )
          ],
        );
      },
    );
  }

  void editTodoHandle(BuildContext context, int index) {
    _titleController.text = _myList[index]['หัวข้อ']!;
    _detailController.text = _myList[index]['รายละเอียด']!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("แก้ไขรายการ"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "ชื่อหัวข้อ"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "รายละเอียด"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _myList[index] = {
                    'หัวข้อ': _titleController.text,
                    'รายละเอียด': _detailController.text
                  };
                });
                _titleController.clear();
                _detailController.clear();
                Navigator.pop(context);
              },
              child: const Text("บันทึก"),
            )
          ],
        );
      },
    );
  }

  void deleteTodoHandle(int index) {
    setState(() {
      _myList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการที่ต้องทำ By Saran Sunsang"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _myList.isEmpty
          ? const Center(child: Text('ยังไม่มีรายการ'))
          : ListView.builder(
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        _myList[index]['หัวข้อ']!,
                        style: const TextStyle(
                          fontSize: 18, // กำหนดขนาดตัวอักษร
                          fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
                        ),
                      ),
                      subtitle: Text(_myList[index]['รายละเอียด']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              editTodoHandle(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteTodoHandle(index);
                            },
                          ),
                        ],
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
