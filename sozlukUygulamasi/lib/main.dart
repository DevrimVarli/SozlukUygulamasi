import 'package:flutter/material.dart';
import 'package:sozlukuygulamasi/DetaySayfasi.dart';
import 'package:sozlukuygulamasi/Kelimeler.dart';
import 'package:sozlukuygulamasi/Kelimelerdao.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool aramaYapiliyorMu=false;
  String aramaKelimesi="";
  var tfC=TextEditingController();

  Future<List<Kelimeler>> kelimeleriGetir() async{
    var kelimeListesi = await Kelimelerdao().kelimeGetir();
    return kelimeListesi;
  }
  Future<List<Kelimeler>> AranankelimeleriGetir(String aramaKelimesi) async{
    var kelimeListesi=await Kelimelerdao().kelimeArama(aramaKelimesi);
    return kelimeListesi;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: aramaYapiliyorMu ?

          TextField(
            controller: tfC,
            decoration: InputDecoration(
              hintText: "Arama için birşey yazın"
            ),
            onChanged: (aramaSonucu){
              print("Arama sonucu: $aramaSonucu");
              setState(() {
                aramaKelimesi=aramaSonucu;
              });
            },

          ) : Text("Anasayfa"),
        actions: [
          aramaYapiliyorMu ? IconButton(
              onPressed: (){
               setState(() {
                 tfC.text="";
                 aramaYapiliyorMu=false;
               });
              },
              icon:Icon(Icons.cancel)):IconButton(
              onPressed: (){
                setState(() {
                    aramaYapiliyorMu=true;
                              });
                    }, icon: Icon(Icons.search),),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyorMu? AranankelimeleriGetir(aramaKelimesi): kelimeleriGetir(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimeListesi=snapshot.data;
            return ListView.builder(
                itemCount: kelimeListesi!.length,
                itemBuilder: (context,indeks){
                  var kelime=kelimeListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfasi(kelime: kelime)));
                    },
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        color: Colors.deepOrangeAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${kelime.kelime_ingilizce}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                            Text("${kelime.kelime_turkce}",style: TextStyle(fontSize: 20),),


                          ],
                        ),
                      ),
                    ),
                  );
                });
          }else{
            
            
            return Center(child: Text("Veri Bulunamadı"),);
            
            
          }
        },
      )

    );
  }
}
