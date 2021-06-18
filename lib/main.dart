import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main()=>runApp(MaterialApp(home:RawKeyboardListenerWidget()));
class RawKeyboardListenerWidget extends StatefulWidget {
  RawKeyboardListenerWidget();

  @override
  _RawKeyboardListenerState createState() => new _RawKeyboardListenerState();
}

class _RawKeyboardListenerState extends State<RawKeyboardListenerWidget> {
  TextEditingController _controller = new TextEditingController();
  FocusNode _textNode = new FocusNode();

  @override
  initState() {
    super.initState();
  }

  //Handle when submitting
  void _handleSubmitted(String finalinput) {
    setState(() {
      SystemChannels.textInput
          .invokeMethod('TextInput.hide'); //hide keyboard again
      _controller.clear();
    });
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keycode of key event (66 is return)

    print("why does this run twice $_keyCode");
  }

  _buildTextComposer() {
    TextField _textField = new TextField(
      controller: _controller,
      onSubmitted: _handleSubmitted,
    );
    FocusScope.of(context).requestFocus(_textNode);
    return  RawKeyboardListener(
        focusNode: _textNode,
        onKey: (event) {
          // Only taking key down event into consideration
          if (event.runtimeType == RawKeyDownEvent) {
            bool shiftPressed = event.isShiftPressed; // true: if shift key is pressed
          }
        },
        child: _textField
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildTextComposer(),
    );
  }
}