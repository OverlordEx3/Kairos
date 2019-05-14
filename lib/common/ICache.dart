import 'dart:async' show Future;

abstract class ICache<K, T> {
	Future<T> get(K key);
	Future<List<T>> contents();
	Future<Null> add(K key, T item);
	Future<Null> addAll(Map<K, T> items);
	Future<bool> containsValue(T item);
	Future<bool> containsKey(K key);
	Future<Null> remove(K key);
	Future<Null> update(K key, T item);
	Future<bool> isEmpty();
}