class Asset {
  final String name ;
  final int qua ;
  final String url;
  final String type;
  final String desc;
  Asset(this.name , this.qua , this.url , this.type , this.desc);

}
class Log {
  final String name ;
  final int qua ;
  //final String url;
  final String type;
  //final String desc;
  final DateTime time;
  final bool status;
  Log(this.name , this.qua , this.status , this.type , this.time);

}