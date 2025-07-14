import 'package:ambition_delivery/domain/entities/item.dart';
import 'package:ambition_delivery/domain/repositories/item_repository.dart';

class GetAllItems {
  final ItemRepository repository;

  GetAllItems(this.repository);

  Future<List<Item>> call() async {
    return await repository.getItems();
  }
}
