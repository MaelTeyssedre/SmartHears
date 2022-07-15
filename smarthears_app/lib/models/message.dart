class Message {
  final String sender;
  final String receiver;
  final String id;
  final String text;
  final DateTime date;

  Message({required this.date, required this.id, required this.receiver, required this.sender, required this.text});
}
