class sort {
  String sortName(String theRequiredTosort) {
    List<String> charList = theRequiredTosort.split('');
    charList.sort();

    String sortedName = charList.join();
    return sortedName;
  }
}
