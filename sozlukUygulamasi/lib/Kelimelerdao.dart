import 'package:sozlukuygulamasi/Kelimeler.dart';
import 'package:sozlukuygulamasi/VeritabaniYardimcisi.dart';

class Kelimelerdao{

  Future<List<Kelimeler>> kelimeGetir() async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM kelimeler ");
    return List.generate(maps.length, (i){
      var satir=maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);

    });

  }
  Future<List<Kelimeler>> kelimeArama(String aramaKelimesi) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramaKelimesi%'");
    return List.generate(maps.length, (i){
      var satir=maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);

    });

  }



}