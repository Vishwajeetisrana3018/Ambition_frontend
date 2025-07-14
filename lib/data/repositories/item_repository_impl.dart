import 'package:ambition_delivery/data/datasources/remote_data_source.dart';
import 'package:ambition_delivery/data/models/item_model.dart';
import 'package:ambition_delivery/domain/entities/item.dart';
import 'package:ambition_delivery/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final RemoteDataSource itemDataSource;

  ItemRepositoryImpl(this.itemDataSource);

  @override
  Future<List<Item>> getItems() async {
    final resp = await itemDataSource.getItems();
    return (resp.data as List).map((e) => ItemModel.fromJson(e)).toList();
  }
}
