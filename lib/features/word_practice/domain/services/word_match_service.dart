class WordMatchService {
  bool isPronunciationMatch(String target, String recognized) {
    final t = target.toLowerCase().trim();
    final r = recognized.toLowerCase().trim();
    return r.contains(t) || t.contains(r);
  }

  bool isExactMatch(String target, String typed) {
    return target.toLowerCase().trim() == typed.toLowerCase().trim();
  }
}
