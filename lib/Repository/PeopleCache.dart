import 'dart:async' show Future;
import 'package:count_me_in/common/ICache.dart' show ICache;
import 'dart:collection' show HashMap;
import '../models/PeopleModel.dart' show People;

class PeopleHashCache implements ICache<int, People> {
	final _cache = HashMap<int, People>();

  @override
  Future<Null> add(int key, People item) async {
    _cache[key] = item;
    return null;
  }

  @override
  Future<Null> addAll(Map<int, People> items) async {
    _cache.addAll(items);
    return null;
  }

  @override
  Future<bool> containsKey(int key) async {
    return _cache.containsKey(key);
  }

  @override
  Future<bool> containsValue(People item) async {
    return _cache.containsValue(item);
  }

  @override
  Future<List<People>> contents() async {
    return _cache.values.toList();
  }

  @override
  Future<People> get(int key) async {
  	if(await containsKey(key) != true) {
  		return null;
	  }

    return _cache[key];
  }

  @override
  Future<bool> isEmpty() async{
    return _cache.isEmpty;
  }

  @override
  Future<Null> remove(int key) async {
    _cache.remove(key);
    return null;
  }

  @override
  Future<Null> update(int key, People item) async {
  	if(await containsKey(key) != true) {
  		add(key, item);
  		return null;
	  }

  	_cache[key] = item;
    return null;
  }
}
