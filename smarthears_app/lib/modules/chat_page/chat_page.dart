import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/chat_page/bloc/chat_bloc.dart';
import 'package:smarthears_app/modules/splash/splash.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ChatBloc>(context);
    bloc.add(FetchChatEvent(id: widget.id));
    super.initState();
  }

  Widget _buildLoaded(ChatLoadedState state) => Container(height: 500, width: 500, color: Colors.pink);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ChatBloc, ChatState>(bloc: bloc, builder: (context, state) => state is ChatLoadedState ? _buildLoaded(state) : const SplashPage());
}
