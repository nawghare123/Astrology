import 'package:consultant_product/src/modules/chat/fetch_messages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class ChatLogic extends GetxController {
  final ChatState state = ChatState();
  final TextEditingController messageController = TextEditingController();
  bool? getMessagesLoader = true;

  updateGetMessagesLoader(bool? newValue) {
    getMessagesLoader = newValue;
    update();
  }

  // final ScrollController messageScrollController = ScrollController();
  List messageList = [];
  updateMessageList(newValue) {
    messageList.add(newValue);
    update();
  }

  emptyMessageList() {
    messageList = [];
    update();
  }

  bool? showSendIcon = false;
  updateShowSendIcon(bool? newValue) {
    showSendIcon = newValue;
    update();
  }

  int? senderMessageGetId;

  updateSenderMessageGetId(int? newValue) {
    senderMessageGetId = newValue;
    update();
  }

  int? receiverMessageGetId;

  updateReceiverMessageGetId(int? newValue) {
    receiverMessageGetId = newValue;
    update();
  }

  FetchMessagesModel fetchMessagesModel = FetchMessagesModel();

  ScrollController? scrollController;
  ScrollController? chatScrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  String? userName;
  String? userEmail;
  String? userImage;

  void updateUserName(String name) {
    userName = name;
    update();
  }

  void updateUserEmail(String name) {
    userEmail = name;
    update();
  }

  void updateUserImage(String name) {
    userImage = name;
    update();
  }
}
