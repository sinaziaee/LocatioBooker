class Message {
  String user, text, dateTime, repliedMessageText, repliedMessageUser, url;
  int textId, repliedMessageId;
  bool isMe;
  int userId;

  Message({
    this.text,
    this.user,
    this.textId,
    this.url,
    this.dateTime,
    this.repliedMessageId,
    this.repliedMessageText,
    this.repliedMessageUser,
    this.isMe,
    this.userId,
  });
}
