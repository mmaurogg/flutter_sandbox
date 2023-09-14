class Preference {
  String? id;
  String? name;
  String? description;
  String? iconUrl;
  String? iconId;
  int? creationDate;
  int? lastModificationDate;
  String? creationUserId;
  String? lastModificationUserId;
  String? status;
  String? color;
  String? colorId;

  Preference(
      {this.id,
      this.name,
      this.description,
      this.iconUrl,
      this.iconId,
      this.creationDate,
      this.lastModificationDate,
      this.creationUserId,
      this.lastModificationUserId,
      this.status,
      this.color,
      this.colorId});

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
      iconId: json['iconId'],
      creationDate: json['creationDate'],
      lastModificationDate: json['lastModificationDate'],
      creationUserId: json['creationUserId'],
      lastModificationUserId: json['lastModificationUserId'],
      status: json['status'],
      color: json['color'],
      colorId: json['colorId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['iconUrl'] = this.iconUrl;
    data['iconId'] = this.iconId;
    data['creationDate'] = this.creationDate;
    data['lastModificationDate'] = this.lastModificationDate;
    data['creationUserId'] = this.creationUserId;
    data['lastModificationUserId'] = this.lastModificationUserId;
    data['status'] = this.status;
    data['color'] = this.color;
    data['colorId'] = this.colorId;
    return data;
  }
}
