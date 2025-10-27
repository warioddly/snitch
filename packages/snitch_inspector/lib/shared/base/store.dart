
abstract class Store {

  void set(String key, dynamic value);

  T? get<T>(String key);

  void remove(String key);

}