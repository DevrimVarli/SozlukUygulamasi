import 'package:flutter/material.dart';
import 'package:sozlukuygulamasi/Kelimeler.dart';

class DetaySayfasi extends StatefulWidget {
  Kelimeler kelime;

  DetaySayfasi({required this.kelime});

  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Detay Sayfasi"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.kelime.kelime_ingilizce}",style: TextStyle(fontSize: 40,color: Colors.pink),),
            Text("${widget.kelime.kelime_turkce}",style: TextStyle(fontSize: 40,color: Colors.black),),
          ],

        ),
      ),
    );
  }
}
