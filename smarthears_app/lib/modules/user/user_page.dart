import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
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
        Row(children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black),
                      labelText: 'FirstName *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.firstname,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today, color: Colors.black),
                      labelText: 'BirthDate *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                    initialValue: DateFormat('yyyy-MM-dd – kk:mm')
                        .format(widget.user.birthDate as DateTime),
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.emoji_flags, color: Colors.black),
                      labelText: 'Country *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.country,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.accessible_forward, color: Colors.black),
                      labelText: 'ID *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.id,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black),
                      labelText: 'LastName *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.lastname,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_location, color: Colors.black),
                      labelText: 'City *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.city,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.local_phone, color: Colors.black),
                      labelText: 'Phone *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.phone,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail, color: Colors.black),
                      labelText: 'E-Mail *',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    initialValue: widget.user.email,
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
              ],
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
