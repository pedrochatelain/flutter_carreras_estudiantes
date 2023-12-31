// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:flutter/material.dart';
import 'data_table_carreras.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 44,
              backgroundColor: Colors.deepOrange,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  color: Colors.white,
                  onPressed: () => {},
                  icon: Icon(Icons.arrow_back)),
              title: Text(
                  style: TextStyle(color: Colors.white), "Material app 3?"),
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.deepOrange[100],
                tabs: [
                  Tab(text: 'CARRERAS', icon: Icon(Icons.history_edu_rounded)),
                  Tab(text: 'ESTUDIANTES', icon: Icon(Icons.school_rounded)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CarrerasPage(),
                Center(child: Text('Estudiantes')),
              ],
            ),
          ),
        ));
  }
}

class CarrerasPage extends StatefulWidget {
  const CarrerasPage({super.key});

  @override
  State<CarrerasPage> createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage>
    with AutomaticKeepAliveClientMixin<CarrerasPage> {
  var valorInicial = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.all(5),
          child: FloatingActionButton(
              child: Icon(size: 35, color: Colors.white, Icons.add),
              backgroundColor: Colors.deepOrange,
              onPressed: () => setState(() {
                    valorInicial = valorInicial * -1;
                  })),
        ),
        body: Center(
            // width: double.infinity,
            // margin: EdgeInsets.only(top: 30),
            child: DataTableCarreras()));
  }

  Widget getWidget() => (valorInicial == 1)
      ? CircularProgressIndicator()
      : Container(
          margin: EdgeInsets.only(bottom: 450),
          width: double.infinity,
          child: DataTableCarreras());

  @override
  bool get wantKeepAlive => true;
}
