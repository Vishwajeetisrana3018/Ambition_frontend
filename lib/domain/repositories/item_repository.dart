import 'package:ambition_delivery/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
}
