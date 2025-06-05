class CreateDiagnoseData {
  CreateDiagnoseData({
      this.appointID, 
      this.assignedClinic, 
      this.finalDiagnose, 
      this.toothNumbers,});

  CreateDiagnoseData.fromJson(dynamic json) {
    appointID = json['appointID'];
    assignedClinic = json['assignedClinic'];
    finalDiagnose = json['finalDiagnose'];
    toothNumbers = json['toothNumbers'] != null ? json['toothNumbers'].cast<num>() : [];
  }
  String? appointID;
  String? assignedClinic;
  String? finalDiagnose;
  List<num>? toothNumbers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointID'] = appointID;
    map['assignedClinic'] = assignedClinic;
    map['finalDiagnose'] = finalDiagnose;
    map['toothNumbers'] = toothNumbers;
    return map;
  }

}