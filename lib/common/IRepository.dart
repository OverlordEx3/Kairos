import 'dart:async' show Future;

abstract class IRepository<T> {
	Future<T> get({Map<String, dynamic> whereArgs});
	Future<List<T>> getAll({Map<String, dynamic> whereArgs});
	Future<T> add({Map<String, dynamic> params});
	Future<bool> delete(int key, T item);
	Future<T> update(int key, {Map<String, dynamic> params, Map<String, dynamic> whereArgs});
}