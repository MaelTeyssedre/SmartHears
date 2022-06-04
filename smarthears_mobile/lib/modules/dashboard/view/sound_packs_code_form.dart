import 'package:smarthears_mobile/repositories/content_page_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

typedef CheckCodeCallback = void Function(bool);

class PasswordForm extends StatefulWidget {
  PasswordForm(
      {required this.id,
      required this.callback,
      required this.isSoundPack,
      required this.isEntity});

  final String id;
  final CheckCodeCallback callback;
  final bool isSoundPack;
  final bool isEntity;

  @override
  _SoundPacksCodeForm createState() => _SoundPacksCodeForm();
}

class _SoundPacksCodeForm extends State<PasswordForm> {
  late TextEditingController _controller;
  late ValueNotifier<String?> _error;
  FocusNode _focus = new FocusNode();
  double height = 200;

  @override
  void initState() {
    _error = ValueNotifier<String?>(null);
    _controller = TextEditingController();
    _controller.addListener(() => _error.value = null);
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _error.dispose();
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() => (_focus.hasFocus)
      ? setState(() => height = 500)
      : setState(() => height = 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration:const Duration(milliseconds: 150),
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(48, 48, 48, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _SoundPackCodeInput(_controller, _error, _focus),
            const Padding(padding: EdgeInsets.all(12)),
            ElevatedButton(
                onPressed: () => checkCode(),
                key: const Key('exparienceCode_check_raisedButton'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) =>
                            states.contains(MaterialState.disabled)
                                ? Colors.orangeAccent[100]
                                : Colors.orangeAccent),
                    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                        (Set<MaterialState> states) =>
                            states.contains(MaterialState.disabled)
                                ? const TextStyle(color: Colors.black45)
                                : const TextStyle(color: Colors.black45))),
                child: const Text("exparience-code-form.check-button"))
          ],
        ),
      ),
    );
  }

  checkCode() async {
    _error.value = null;
    if (_controller.text.isNotEmpty) {
      if (widget.isSoundPack) {
        var result = await getIt<ContentPageRepository>()
            .checkCode(_controller.text, widget.id);
        if (!result) {
          _error.value = "exparience-code-form.password-error";
        } else {
          widget.callback(true);
        }
      }
    }
  }
}

class _SoundPackCodeInput extends StatelessWidget {
  const _SoundPackCodeInput(this._controller, this._error, this._focus);

  final TextEditingController _controller;
  final ValueNotifier<String?> _error;
  final FocusNode _focus;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: _error,
      builder: (BuildContext context, String? hasError, Widget? child) =>
          TextField(
              focusNode: _focus,
              key: const Key('checkExparienceCode_codeInput_textField'),
              style: const TextStyle(color: Colors.white),
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.qr_code, color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromRGBO(48, 48, 48, 0.8),
                  labelText: "exparience-code-form.password",
                  errorText: _error.value,
                  labelStyle:
                      const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.3)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))))));
}
