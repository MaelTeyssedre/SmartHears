import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/splash/splash.dart';
import 'package:smarthears_app/modules/user/bloc/user_page_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserPageBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UserPageBloc>(context);
    bloc.add(FetchUserEvent(id: widget.id));
    super.initState();
  }

  Widget _buildLoaded(UserPageLoadedState state) => Container(height: 500, width: 500, color: Colors.pink);

  @override
  Widget build(BuildContext context) => BlocBuilder<UserPageBloc, UserPageState>(
      bloc: bloc, builder: (context, state) => state is UserPageLoadedState ? _buildLoaded(state) : const SplashPage());
}
