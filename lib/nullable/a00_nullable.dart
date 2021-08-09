void sub() {
  int? v;
  print(v == null);     // true
  print(v is int);      // false
  print(v is int?);     // true
  print(v is String?);  // true
  print(v is Null?);    // true

  v = 1;
  print(v.runtimeType); // int

  v = null;
  print(v.runtimeType); // Null

  print(v);             // null
  print(v?.isEven);     // nullなら後続のメソッドを実行しない

  var w = v ?? 4;       // nullなら後続の値を返却 (v == null ? 4 : v)
  print(w);             // 4

  v ??= 1;              // nullなら後続の値を設定 (v = (v == null ? 1 : v))
  print(v);             // 1
}
