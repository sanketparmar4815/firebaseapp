import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyviewDatatatataattatatat extends StatefulWidget {
  const MyviewDatatatataattatatat({Key? key}) : super(key: key);

  @override
  State<MyviewDatatatataattatatat> createState() =>
      _MyviewDatatatataattatatatState();
}

class _MyviewDatatatataattatatatState extends State<MyviewDatatatataattatatat> {
  List ss = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ViewFirebaseDatafromRealTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ss.length != 0
          ? ListView.builder(
              itemCount: ss.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${ss[index]['name']}"),
                  leading: Image.network("${ss[index]['imageurl']}"),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> ViewFirebaseDatafromRealTime() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Mydatabse");

    // DatabaseEvent  de = await  ref.once();
    //
    // print("===${de.snapshot.value}");



    ref.onValue.listen((event) {

      Map map = event.snapshot.value as Map;
      ss.clear();
      map.forEach((key, value) {
        setState(() {
          ss.add(value);
        });
      });
    });

    print("LIST===${ss}");

    // FirebaseAnimatedList
  }
}
