import 'package:smarthears_app/models/message.dart';

class ChatRepository {
  ChatRepository();

  Future<List<Message>> getMessages() async {
    List<Message> chat = [
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test'),
      Message(date: DateTime.now(), id: 'id test', receiver: 'receiver test', sender: 'sender test', text: 'text test')
    ];
    return chat;
  }
}
