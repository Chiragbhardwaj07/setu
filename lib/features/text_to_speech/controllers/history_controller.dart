import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HistoryController extends GetxController {
  var messages = <String>[].obs;
  final Box<String> chatBox = Hive.box<String>('historyMessages');

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    messages.value = chatBox.values.toList();
  }

  void addMessage(String message) {
    chatBox.add(message);
    messages.add(message);
  }

  void deleteMessage(index){
    chatBox.deleteAt(index);
    messages.removeAt(index);
  }

  void deleteAll() {
    chatBox.clear();
    messages.clear();
  }
}
