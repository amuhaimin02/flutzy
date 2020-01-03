extension GroupableList<T> on List<T> {
  List<List<T>> group(int count) {
    final groupedList = List<List<T>>((this.length + 1) ~/ count);
    int newIndex;
    var index = 0;

    for (var item in this) {
      newIndex = index++ ~/ count;
      (groupedList[newIndex] ??= <T>[])..add(item);
    }
    return groupedList;
  }
}
