boolean l(String w) {
    // leeres Wort, kein Test in L1 notwendig
    if (w.length() == 0) {
        return true;
    }
    // Beendigung der Rekursion wenn das Wort in L1 ist
    if (l1(w)) {
        return true;
    }
    // Rekursion erforderlich, untersuche alle Unterteilungen
    // (fuer w.length() == 1 wird hier nichts ausgefuehrt)
    for (int i = 1; i < w.length(); i++) {
        String w1 = w.substring(0, i);
        String w2 = w.substring(i);
        if (l1(w1) && l(w2)) {
            return true;
        }
    }
    return false;
}
