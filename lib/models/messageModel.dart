class MessageModel {
  String? resiverId;
  String? senderId;
  String? text;
  String? dateTime;

  // bool? isEmailVerified;
  MessageModel({this.resiverId, this.senderId, this.dateTime, this.text
      // this.isEmailVerified
      });
  MessageModel.fromJson(Map<String, dynamic> json) {
    resiverId = json['resiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'resiverId': resiverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
