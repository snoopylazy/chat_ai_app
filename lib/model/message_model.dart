class MessageModel {
  String? msg;
  int? sendId;

  /// 0-> User , 1-> bot
  String? sendAt;
  bool? isRead;

  MessageModel(
      {required this.msg,
      required this.sendAt,
      required this.sendId,
      this.isRead = false});
}
