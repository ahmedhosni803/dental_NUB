class CaseDetails {
  CaseDetails({
      this.assignedClinic, 
      this.finalDiagnose, 
      this.toothNumbers,});

  CaseDetails.fromJson(dynamic json) {
    assignedClinic = json['assignedClinic'];
    finalDiagnose = json['finalDiagnose'];
    if(json['toothNumbers'] != null){
      toothNumbers = [];
      json['toothNumbers'].forEach((v){
        toothNumbers?.add(num.parse(v.toString()));
      });
    }

  }
  String? assignedClinic;
  String? finalDiagnose;
  List<num>? toothNumbers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['assignedClinic'] = assignedClinic;
    map['finalDiagnose'] = finalDiagnose;
    map['toothNumbers'] = toothNumbers;
    return map;
  }

}