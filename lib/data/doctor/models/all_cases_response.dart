class AllCasesResponse {
  AllCasesResponse({
      this.data,});

  AllCasesResponse.fromJson(dynamic json) {
    if (json != null) {
      data = [];
      json.forEach((v) {
        data?.add(Case.fromJson(v));
      });
    }
  }
  List<Case>? data;


}

class Case {
  Case({
      this.caseID, 
      this.appointID,
      this.patientName,
      this.age, 
      this.patPhone, 
      this.chronicalDiseases,});

  Case.fromJson(dynamic json) {

    caseID = json['caseID'];
    appointID = json['appointID'].toString();
    patientName = json['patientName'];
    age = json['age'];
    patPhone = json['patPhone'];
    chronicalDiseases = json['chronicalDiseases'];
  }
  num? caseID;
  String? patientName;
  String? appointID;
  num? age;
  String? patPhone;
  String? chronicalDiseases;


}