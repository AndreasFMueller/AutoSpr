boolean l(String w) {
    for (int i = 0; i <= w.length(); i++) {
        String w1 = w.substring(0, i);
        String w2 = w.substring(i);
        if (l1(w1) && l2(w2)) {
            return true;
        }
    }
    return false;
}
