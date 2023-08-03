class ServiceMetting {
  late final int id;
  late final String serviceName;
  late final String preacher;
  late final int attendance;
  late final int newComer;
  late final int newConvert;
  late final int offrandes;
  late final int tithes;
  late final int bacenterLeader;
  late final String date;





  ServiceMetting.fromJson(Map <String, dynamic> json)
      : id = json['id'],
       serviceName = json['service_name'],
       preacher  = json['predicator'],
       attendance = json['attendance'],
       newComer =  json['new_comer'],
       newConvert = json['new_convert'],
       offrandes = json['offrandes'],
       tithes = json["tithes"],
       bacenterLeader  = json['bacenter_leader'],
       date = json['date'];

}