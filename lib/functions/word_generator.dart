import 'dart:math';

class GenerateWord {
  guestWord(String text) {
    var hiddenWord = text;
    var len = text.length;
    var minHiddenLetters = ((len / 2).round() / 2).round();
    var maxHiddenLetters = (len / 2).round();

    var lettersHidden = minHiddenLetters + Random().nextInt((maxHiddenLetters + 1) - minHiddenLetters);

    while ('—'.allMatches(hiddenWord).length != lettersHidden) {
      var rand = Random().nextInt(len);
      hiddenWord = hiddenWord.replaceRange(rand, rand+1, "—");
    }
    print("len: $len, maxHiddenLetters: $maxHiddenLetters, minHiddenLetters: $minHiddenLetters, lettersHidden: $lettersHidden");

    return hiddenWord;
  }
}
