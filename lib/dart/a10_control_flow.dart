void sub() {
  final iList = <int>[1, 2, 3, 4, 5, 6];

  // for
  print('---- for');
  for (var i = 0; i < 3; i++) {
    print(iList[i]);
  }

  // for-in
  print('---- for-in');
  for (var e in iList) {
    print(e);
  }

  // forEach-1
  print('---- forEach-1');
  iList.forEach((e) {
    print(e);
  });

  // forEach-2
  print('---- forEach-2');
  iList.forEach(print);

  // while & break
  print('---- while & break');
  var i = 0;
  while (i < iList.length) {
    print(iList[i++]);
    if (i >= 3) {
      break;
    }
  }

  // where & foreach
  print('---- where & foreach');
  iList.where((e) => e < 4).forEach(print);

  // if & else if & else
  print('---- if & else if & else');
  for (var i = 0; i < 3; i++) {
    if (iList[i] == 1) {
      print('one');
    } else if (iList[i] == 2) {
      print('two');
    } else {
      print('other');
    }
  }

  // switch-case & break & continue
  print('---- switch-case & break & continue');
  for (var e in iList) {
    switch (e) {
      case 1:
        print('one');
        break;
      case 2:
        print('even');
        continue LABEL1;
      LABEL1:
      case 3:
      case 4:
      case 5:
      case 6:
        print('others: $e');
        break;
    }
  }

  // assert
  print('---- assert');
  for (var e in iList) {
    print(e);
    assert(e != 4);
  }
}
