import '../models/PeopleModel.dart';
import '../Provider/IProvider.dart' show IProvider;
import 'IRepository.dart' show IRepository;
import 'ICache.dart' show ICache;

class PeopleRepository implements IRepository<People> {
  final IProvider<People> provider;
  final ICache<int, People> cache;

  PeopleRepository({this.provider, this.cache});

  @override
  Future<People> add({Map<String, dynamic> params}) async {
    final person = await provider.add(params);
    cache.add(person.hashCode, person);
    return person;
  }

  @override
  Future<bool> delete(int key, People item) async {
    cache.remove(key);
    return provider.delete(item.uid);
  }

  @override
  Future<People> get({Map<String, dynamic> whereArgs}) async {
    if(await cache.containsKey(whereArgs['hashcode']) != true) {
      return provider.retrieve(whereArgs: whereArgs);
    }
    return cache.get(whereArgs['hashcode']);
  }

  @override
  Future<List<People>> getAll({Map<String, dynamic> whereArgs}) async {
    if (await cache.isEmpty()) {
      final result = await provider.retrieveAll(whereArgs: whereArgs);
      cache.addAll(Map.fromIterable(result,
          key: (item) => item.hashCode, value: (item) => item));
      return result;
    }
    return cache.contents();
  }

  @override
  Future<People> update(int key,
      {Map<String, dynamic> params, Map<String, dynamic> whereArgs}) async {
    cache.remove(key);
    final person = People(
        uniqueID: params['uid'],
        name: params['name'],
        surname: params['surname'],
        shortBio: params['shortbio'],
        sectionID: params['section']);
    cache.add(person.hashCode, person);

    await provider.update(person, whereArgs: whereArgs);
    return null;
  }
}
