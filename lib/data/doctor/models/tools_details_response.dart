class ToolsDetailsResponse {
  ToolsDetailsResponse({
      this.toolPostID, 
      this.toolName, 
      this.price, 
      this.isFree, 
      this.imageUrl, 
      this.doctorName, 
      this.doctorPhone,});

  ToolsDetailsResponse.fromJson(dynamic json) {
    toolPostID = json['toolPostID'];
    toolName = json['toolName'];
    price = json['price'];
    isFree = json['isFree'];
    imageUrl = json['imageUrl'];
    doctorName = json['doctorName'];
    doctorPhone = json['doctorPhone'];
  }
  num? toolPostID;
  String? toolName;
  dynamic price;
  bool? isFree;
  String? imageUrl;
  String? doctorName;
  String? doctorPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toolPostID'] = toolPostID;
    map['toolName'] = toolName;
    map['price'] = price;
    map['isFree'] = isFree;
    map['imageUrl'] = imageUrl;
    map['doctorName'] = doctorName;
    map['doctorPhone'] = doctorPhone;
    return map;
  }

}