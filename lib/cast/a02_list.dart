void sub() {
  // List<dynamic>
  List<dynamic> dList1 = <dynamic>['1', '2', '3'];
  print(dList1.runtimeType);
  print(dList1.toString());

  // List<dynamic>　→　List<String>
  List<String> sList1 = dList1.cast<String>();
  print(sList1.runtimeType);
  print(sList1.toString());

  // List<dynamic>　→　List<int>
  List<int> iList1 =
      dList1.cast<String>().map((e) => int.parse(e)).toList(); //OK
  /// dList1.cast<int>(); //NG: exception
  /// dList1.map((dynamic e) => int.parse(e as String)).toList(); //OK
  print(iList1.runtimeType);
  print(iList1.toString());

  // List<String>　→　List<dynamic>
  List<dynamic> dList2 = List<dynamic>.from(sList1);
  print(dList2.runtimeType);
  print(dList2.toString());

  // List<dynamic>?
  List<dynamic>? ndList1 = <dynamic>['a', 'b', 'c'];
  print(ndList1.runtimeType);
  print(ndList1.toString());

  // List<dynamic>?　→　List<String>?
  List<String>? nsList1 = ndList1.cast<String>();
  print(nsList1.runtimeType);
  print(nsList1.toString());

  // String<>?　→　List<dynamic>?
  List<dynamic>? ndList2 = List<dynamic>.from(nsList1);
  print(ndList2.runtimeType);
  print(ndList2.toString());
}
