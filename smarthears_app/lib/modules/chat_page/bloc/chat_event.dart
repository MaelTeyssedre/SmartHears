part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class FetchChatEvent extends ChatEvent {
  final String id;
  const FetchChatEvent({required this.id});
}
