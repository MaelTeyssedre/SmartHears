import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/models/theme.dart';
import 'package:smarthears_app/models/user.dart';
import 'package:smarthears_app/modules/splash/splash.dart';
import 'package:smarthears_app/modules/user/bloc/user_page_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.id, required this.user})
      : super(key: key);

  final String id;
  final User user;

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

  Widget _buildLoaded(UserPageLoadedState state) => Container(
      color: theme.colorScheme.background,
      child: Column(children: <Widget>[
        const SizedBox(
          height: 210,
        ),
        Row(children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: const Text("Firstname: ",
                  style: TextStyle(fontSize: 15.0, color: Colors.black)),
              subtitle: Center(
                  child: Text(widget.user.firstname as String,
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black))),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: const Text("Lastname: ",
                  style: TextStyle(fontSize: 15.0, color: Colors.black)),
              subtitle: Center(
                  child: Text(widget.user.lastname as String,
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black))),
            ),
          ),
        ])
      ]));
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserPageBloc, UserPageState>(
          bloc: bloc,
          builder: (context, state) => state is UserPageLoadedState
              ? _buildLoaded(state)
              : const SplashPage());
}
