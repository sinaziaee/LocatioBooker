class Message {
  String currentUsername, text, dateTime, repliedMessageText, repliedMessageUser, url;
  int textId, repliedMessageId, currentUserId;
  bool isMe;
  int chatRoomId;

  Message({
    this.text,
    this.currentUsername,
    this.textId,
    this.url,
    this.dateTime,
    this.repliedMessageId,
    this.repliedMessageText,
    this.repliedMessageUser,
    this.isMe,
    this.chatRoomId,
    this.currentUserId,
  });
}
