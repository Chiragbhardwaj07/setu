import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vasu/features/text_to_speech/controllers/history_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:vasu/features/text_to_speech/utils/utils.dart' as utils;
import 'package:vasu/shared/appbar/view_appbar.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vasu/shared/constants/app_proportions.dart';
import '../../../shared/constants/app_colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  String _img = 'space';
  String _ext = '.png';
  String _path = 'assets/letters/';
  String _displaytext = 'Press the button and start speaking...';
  int _state = 0;
  TextEditingController textEditingController = TextEditingController();
  final HistoryController controller = Get.put(HistoryController());
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                appbar(
                  initialFloatingIcon: Icons.compare_arrows_rounded,
                  onFloatingButtonPressed: () {},
                  Title: "Text to ISL",
                  HamBurgerAction: () {
                    Navigator.pop(context);
                  },
                  ImgPath: "assets/icons/back.png",
                ),
                SizedBox(
                  height: AppProportions.verticalSpacing,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Image(
                      image: AssetImage('$_path$_img$_ext'),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      key: ValueKey<int>(_state),
                      width: AppProportions.screenWidth,
                      height: AppProportions.screenHeight * 0.4,
                    ),
                  ),
                  width: AppProportions.screenWidth,
                  height: AppProportions.screenHeight * 0.4,
                ),

                // Row(
                //   children: [
                //     SizedBox(
                //       width: 5,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //           check = !check;
                //           setState(() {});
                //         },
                //         child: Icon(
                //           Icons.arrow_back_rounded,
                //           color: AppColors.PrimaryColor,
                //         )),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          check = !check;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "History",
                            style:
                                Theme.of(context).primaryTextTheme.titleLarge,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: AppProportions.screenHeight * 0.28,
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Message Text
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  controller.messages[index],
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge,
                                ),
                              ),

                              // Action Icons Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        translation(controller.messages[index]);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.PrimaryColor,
                                        radius: 13,
                                        child: Icon(
                                          Icons.play_arrow_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          size: 20,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        controller.deleteMessage(index);
                                        setState(() {});
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.PrimaryColor,
                                        radius: 13,
                                        child: Icon(
                                          Icons.delete,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          size: 20,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (check == false)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.PrimaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: TextField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                          hintText: "Type here...",
                                          border: InputBorder.none,
                                          hintStyle: Theme.of(context)
                                              .primaryTextTheme
                                              .labelLarge),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: AppColors.PrimaryColor,
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                    onPressed: () {
                                      // Define your action here
                                      textEditingController.text =
                                          textEditingController.text.trim();

                                      FocusScope.of(context).unfocus();
                                      if (textEditingController
                                          .text.isNotEmpty) {
                                        controller.addMessage(
                                            textEditingController.text);
                                        translation(textEditingController.text);
                                        textEditingController.clear();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        AvatarGlow(
                          animate: _isListening,
                          glowColor: Theme.of(context).primaryColor,
                          startDelay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.PrimaryColor,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: FloatingActionButton(
                                heroTag: 'btn1',
                                shape: OvalBorder(),
                                onPressed: _listen,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0,
                                child: Icon(
                                  _isListening ? Icons.mic : Icons.mic_none,
                                  color: AppColors.PrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 12, right: 12, bottom: 3),
                    child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.PrimaryColor,
                            ),
                            onPressed: () {
                              controller.deleteAll;
                            },
                            child: Text(
                              "Clear All",
                            ))),
                  ),
              ],
            ),
          ),
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                setState(() {
                  _text = '';
                  _path = 'assets/letters/';
                  _img = 'space';
                  _ext = '.png';
                  _displaytext = 'Press the button and start speaking...';
                  _state = 0;
                });
              },
            );
          },
        ),
      ),
    );
  }

  // void _listen() async {
  //   if (!_isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val){
  //         print('onStatus: $val');
  //         if (val == 'notListening')
  //         {
  //           // Automatically stop if there's silence or user stops speaking
  //           setState(() => _isListening = false);
  //           _speech.stop();
  //         }},
  //       onError: (val) {
  //         if (val == 'notListening')
  //         {
  //             // Automatically stop if there's silence or user stops speaking
  //             setState(() => _isListening = false);
  //             _speech.stop();
  //         }
  //         },
  //       debugLogging: true,
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords.trim().toLowerCase();
  //           if (_text.isNotEmpty) {
  //             controller.addMessage(_text);
  //             translation(_text);
  //           }
  //         }),
  //         listenMode: ListenMode.confirmation,
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //     // _text=_text.trim().toLowerCase();
  //     // if(_text!="") {
  //     //   controller.addMessage(_text);
  //     //   translation(_text);
  //     //   _state = 0;
  //     // }
  //   }
  // }
  // void _listen() async {
  //   if (!_isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) {
  //         print('onStatus: $val');
  //         if (val == 'notListening') {
  //           // Brief delay to ensure user is done speaking
  //           Future.delayed(Duration(milliseconds: 500), () {
  //             if (_isListening) {
  //               setState(() => _isListening = false);
  //               _speech.stop();
  //               _storeAndTranslateText();
  //             }
  //           });
  //         }
  //       },
  //       onError: (val) {
  //         print('onError: $val');
  //         if (val.errorMsg == 'network') {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text("Network error. Check your connection.")),
  //           );
  //         }
  //         setState(() => _isListening = false);
  //       },
  //       debugLogging: true,
  //     );
  //
  //     if (available) {
  //       setState(() => _isListening = true);
  //
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords.trim().toLowerCase();
  //         }),
  //         listenMode: ListenMode.dictation, // Allows for continuous listening
  //       );
  //     }
  //   } else {
  //     // Stop listening if already active
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //     _storeAndTranslateText();
  //   }
  // }

// Helper function to store and translate text if not empty
//   void _storeAndTranslateText() {
//     if (_text.isNotEmpty) {
//       controller.addMessage(_text);
//       translation(_text);
//       _text = ""; // Clear after storing to reset for next input
//     }
//   }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'notListening') {
            Future.delayed(Duration(milliseconds: 500), () {
              if (!_isListening) {
                _speech.stop();
                setState(() => _isListening = false);
                _storeAndTranslateText();
              }
            });
          }
        },
        onError: (val) {
          print('onError: $val');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${val.errorMsg}")),
          );
          setState(() => _isListening = false);
        },
        debugLogging: true,
      );

      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords.trim().toLowerCase();
          }),
          listenMode: ListenMode.confirmation,
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      _storeAndTranslateText();
    }
  }

  void _storeAndTranslateText() {
    if (_text.isNotEmpty) {
      controller.addMessage(_text);
      translation(_text);
      _text = ""; // Clear for next input
    }
  }

  void translation(String _text) async {
    _displaytext = '';
    String speechStr = _text.toLowerCase();

    // -------- logic - detect phrases --------------------
    // List<String> subList = [];
    // List<String> strArray = filterKnownStr(speechStr, utils.phrases, subList);
    // -------- end logic - detect phrases ----------------

    // if(utils.phrases.contains(speechStr)){
    //   String file = speechStr;
    //   setState(() {
    //     _display_text += _text;
    //     _path = 'assets/ISL_Gifs/';
    //     _img = file;
    //     _ext = '.gif';
    //   });
    //   await Future.delayed(const Duration(milliseconds: 11000));
    //   // return false;
    // } else {
    List<String> strArray = speechStr.split(" ");

    for (String content in strArray) {
      // print('$content');
      // if(utils.phrases.contains(content)){
      //   String file = content;
      //   int idx = utils.phrases.indexOf(content);
      //   int _duration = int.parse(utils.phrases.elementAt(idx+1));
      //   // print('$_duration');
      //   setState(() {
      //     _state += 1;
      //     _displaytext += content;
      //     _path = 'assets/ISL_Gifs/';
      //     _img = file;
      //     _ext = '.gif';
      //   });
      //   await Future.delayed(Duration(milliseconds: _duration));
      //
      // } else
      if (utils.words.contains(content)) {
        String file = content;
        int idx = utils.words.indexOf(content);
        int _duration = int.parse(utils.words.elementAt(idx + 1));
        // print('$_duration');
        setState(() {
          _state += 1;
          _displaytext += content;
          _path = 'assets/ISL_Gifs/';
          _img = file;
          _ext = '.gif';
        });
        await Future.delayed(Duration(milliseconds: _duration));
      } else {
        String file = content;
        if (utils.hello.contains(file)) {
          file = 'hello';
          int idx = utils.words.indexOf(file);
          int _duration = int.parse(utils.words.elementAt(idx + 1));
          // print('$_duration');
          setState(() {
            _state += 1;
            _displaytext += content;
            _path = 'assets/ISL_Gifs/';
            _img = file;
            _ext = '.gif';
          });
          await Future.delayed(Duration(milliseconds: _duration));
        } else if (utils.you.contains(file)) {
          file = 'you';
          int idx = utils.words.indexOf(file);
          int _duration = int.parse(utils.words.elementAt(idx + 1));
          // print('$_duration');
          setState(() {
            _state += 1;
            _displaytext += content;
            _path = 'assets/ISL_Gifs/';
            _img = file;
            _ext = '.gif';
          });
          await Future.delayed(Duration(milliseconds: _duration));
        } else {
          for (var i = 0; i < content.length; i++) {
            if (utils.letters.contains(content[i])) {
              String char = content[i];
              // print('$alphabet');
              setState(() {
                _state += 1;
                _displaytext += char;
                _path = 'assets/letters/';
                _img = char;
                _ext = '.png';
              });
              await Future.delayed(const Duration(milliseconds: 1500));
            } else {
              String letter = content[i];
              // print('$letter');
              setState(() {
                _state += 1;
                _displaytext += letter;
                _path = 'assets/letters/';
                _img = 'space';
                _ext = '.png';
              });
              await Future.delayed(const Duration(milliseconds: 1000));
            }
          }
        }
      }
      // _display_text += ' ';
      setState(() {
        _state += 1;
        _displaytext += " ";
        _path = 'assets/letters/';
        _img = 'space';
        _ext = '.png';
      });
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }
}

List<String> filterKnownStr(
    String speechStr, List<String> islGif, List<String> finalArr) {
  bool check = true;

  for (String known in islGif) {
    List<String> tmp;
    if (speechStr.contains(known)) {
      check = false;
      tmp = speechStr.split(known);
      tmp[0] = tmp[0].trim();
      finalArr.addAll(tmp[0].split(' '));
      finalArr.add(known);

      if (finalArr.isEmpty) {
        finalArr = ['null'];
      }
      if (tmp.length == 1) {
        return finalArr;
      }
      tmp[1] = tmp[1].trim();
      if (tmp[1] != '') {
        return filterKnownStr(tmp[1], islGif, finalArr);
      } else {
        return finalArr;
      }
    }
  }
  if (check) {
    List<String> tmp = speechStr.split(" ");
    finalArr.addAll(tmp);
    return finalArr;
  }
  return [];
}
