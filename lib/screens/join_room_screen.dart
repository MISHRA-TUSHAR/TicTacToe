import 'package:flutter/material.dart';
import 'package:tic_tac/resources/socket_method.dart';
import 'package:tic_tac/responsive/responsive.dart';
import 'package:tic_tac/widgets/custom_btn.dart';
import 'package:tic_tac/widgets/custom_text.dart';
import 'package:tic_tac/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Responsive(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
              text: "Join Room",
              fontSize: 70,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: 'Enter your Name',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _gameIdController,
              hintText: 'Enter Room id',
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomButton(
                onTap: () => _socketMethods.joinRoom(
                    _gameIdController.text, _nameController.text),
                text: "Join")
          ],
        ),
      ),
    ));
  }
}
