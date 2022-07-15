

part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Message> chat;
  const ChatLoadedState({required this.chat});
}
