class board {
  String? activity;
  String? type;
  String? participants;
  String? price;
  String? link;
  String? key;
  String? accessibility;

  board(
      {this.activity,
        this.type,
        this.participants,
        this.price,
        this.link,
        this.key,
        this.accessibility});

  board.fromJson(Map<String, dynamic> json)
  {
    activity = json['activity'].toString();
    type = json['type'].toString();
    participants = json['participants'].toString();
    price =json['price'].toString();
    link = json['link'].toString();
    key = json['key'].toString();
    accessibility = json['accessibility'].toString();
  }


}
