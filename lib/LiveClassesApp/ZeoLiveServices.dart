import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 191956128,// Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: 'bdfda2411047e472f58b41188cd2fb267ed42459f5dfdd2522856cfd83f8b528',// Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'user_id'+Random().nextInt(10).toString(),// Fill in the userID that you get from Z
        userName: 'user_name'+Random().nextInt(100).toString(),
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}