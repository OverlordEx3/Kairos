import 'dart:async';

enum IProviderLocation{local, remote}

abstract class IProvider<T> {
	final IProviderLocation location;

	IProvider({this.location : IProviderLocation.local});
	///
	/// Retrieve a Item from api, using [whereArgs] map as
	/// A list of conditions. It's intended to retrieve just
	/// ONE item. To retrieve a list of item, see [retrieveAll]
	///
	Future<T> retrieve({Map<String, dynamic> whereArgs});

	///
	/// Retrieves a list of all items from api, using [whereArgs] map as
	/// a list of conditions.
	///
	Future<List<T>> retrieveAll({Map<String, dynamic> whereArgs});

	///
	/// Inserts a new item on database, based on given [params].
	/// As a result, retrieves the item created.
	///
	Future<T> add(Map<String, dynamic> params);

	///
	/// Updates a item, following conditions on [whereArgs].
	/// Returns the updated item
	///
	Future<int> update(T item, {Map<String, dynamic> whereArgs});

	///
	/// Deletes a item from Database.
	/// Returns [true] if deletion succeeded,
	/// or [false] otherwise.
	///
	Future<bool> delete(int key);

	///
	/// Executes a [query] on api, with no return
	///
	Future<void> executeNonQuery(String query);

	///
	/// Executes a [query] on api, returning a list of results
	///
	Future<List<T>> executeQuery(String query);
}