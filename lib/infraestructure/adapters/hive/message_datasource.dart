import 'package:hive/hive.dart';

import '../../../domain/chat/message.dart';
import '../../../domain/chat/sender_type.dart';
import '../message_datasource_adapter.dart';

const _boxName = "messages";

class HiveMessageDatasource extends MessageDatasourceAdapter {
  static Future<Box<Message>> open() async {
    Hive.registerAdapter<Message>(HiveMessageAdapter());
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<Message>(_boxName);
    }
    return Hive.openBox<Message>(_boxName);
  }

  HiveMessageDatasource({
    required Box<Message> box,
  }) : _box = box;

  final Box<Message> _box;

  @override
  Future<Message> add(Message message) async {
    await _box.add(message);
    return message;
  }

  @override
  Future<List<Message>> getAll() async {
    return _box.values.toList();
  }
}

class HiveMessageAdapter extends TypeAdapter<Message> {
  @override
  final typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final typeStr = reader.readString();
    final senderType = SenderType.values.firstWhere(
      (element) => element.toString() == typeStr,
      orElse: () => SenderType.bot,
    );
    final message = reader.readString();
    final dateStr = reader.readString();
    final date = DateTime.parse(dateStr);
    return Message(
      senderType: senderType,
      content: message,
      date: date,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..write(obj.senderType.toString())
      ..write(obj.content)
      ..write(obj.date.toString());
  }
}
