// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String title = "";
  // String description = "";
  List<Todo> todoList = [];
  bool validate_title = false;
  bool validate_description = false;


  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // This will be needed when there are more than 1 pages
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void todo() {
    // Map todoMap = {};

    setState(() {
      titleController.text.isEmpty ? validate_title = true : validate_title = false;
      descriptionController.text.isEmpty ? validate_description = true : validate_description = false;

      if (titleController.text != "" && descriptionController.text != "") {

        Todo todo = Todo(titleController.text, descriptionController.text);

        //todoMap["title"] = titleController.text;
        //todoMap["description"] = descriptionController.text;
        todoList.add(todo);
        titleController.text = "";
        descriptionController.text = "";
      }
      //print("${todoList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
           TextField(
             decoration: InputDecoration(
               errorText: validate_title ? 'Please enter a title' : null,
               border: OutlineInputBorder(),
               hintText: 'Title',),
             controller: titleController,
           ),
          TextField(
            decoration: InputDecoration(
              errorText: validate_description ? 'Please enter a description' : null,
              border: OutlineInputBorder(),
              hintText: 'Description',),
            controller: descriptionController,
          ),
          Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text that the user has entered by using the
                            // TextEditingController.
                            title: Text("${todoList[index].title}"),
                            content: Text("${todoList[index].description}"),
                          );
                        },
                      );
                    },
                      child: Container(
                        //alignment: Alignment.topLeft,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  "Todo ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${todoList[index].title}",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${todoList[index].description}",
                                style: Theme.of(context).textTheme.headline1,
                                maxLines: 3,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    todoList.removeAt(index);
                                  });
                                },
                                child: Text("Delete")
                            )
                          ],
                        ),
                      )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  color: Colors.blue,
                  thickness:6,
                ),
              )
          ),
         ],
       ),
      floatingActionButton: FloatingActionButton(
        onPressed: todo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
