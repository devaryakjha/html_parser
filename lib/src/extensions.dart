extension IterableExtension<T> on List<T> {
  T? safeElementAt(int index, {T Function()? orElse}) {
    if (index < 0 || index >= length) {
      return orElse?.call();
    }
    return elementAt(index);
  }
}
