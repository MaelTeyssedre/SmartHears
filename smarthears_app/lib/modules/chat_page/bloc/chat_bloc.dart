import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_app/models/message.dart';
import 'package:smarthears_app/repositories/chat_repository.dart';

part 'chat_state.dart';
part 'chat_event.dart';

GetIt getIt = GetIt.instance;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<FetchChatEvent>(_onChatRequestedToState);
  }

  FutureOr<void> _onChatRequestedToState(FetchChatEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoadingState());
      List<Message> chat = await getIt<ChatRepository>().getMessages();
      emit(ChatLoadedState(chat: chat));
    } on Exception {
      emit(ChatLoadingState());
      print("error");
    }
  }
}
