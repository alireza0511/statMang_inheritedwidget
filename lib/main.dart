import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InheritedCounter(child: MyHomePage()),
    );
  }
}

class InheritedCounter extends InheritedWidget {
  
  final Widget child;
  final Map _counter = {'val': 0};

  InheritedCounter({this.child}) : super(child: child);

  increment() {
    _counter['val']++;
  }

  get counter => _counter['val'];

  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedCounter of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<InheritedCounter>();
  //   ctx.inheritFromWidgetOfExactType(InheritedCounter);
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext ctx, StateSetter setState) {
      int counter = InheritedCounter.of(ctx).counter;
      Function increment = InheritedCounter.of(ctx).increment;

      return Scaffold(
        appBar: AppBar(
          title: Text('Inherited Widget'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => increment()),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
