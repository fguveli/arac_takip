enum InfoQueries { limit }

//burada farklı sorguları verebilirim. parametre olarak kullandık ama
//sorgu adlarını verip gelen yanıtları doğrudan çağırabilirim
extension InfoQueriesExtension on InfoQueries {
  MapEntry<String, String> toMapEntry(String value) {
    switch (this) {
      case InfoQueries.limit:
        return MapEntry('limit', value);
    }
  }
}
