String convertMoneyToString(int money){
  String unprocessedAmount = money.toString();
  int theAmountStringFinalIdex = unprocessedAmount.length-1;
  //Get the number of times we need the comma sign to separate money with three digits
  int numberOfCommasNeeded = theAmountStringFinalIdex~/3;
  int indexPointer;
  //Loop to add each one of them
  //We start from the end
  for(int i=0; i<numberOfCommasNeeded; i++){
    //Index of where we are
    //First subtract the instances done then 3 to get to the index where we are adding the comma
    int ourCurrentIndex = theAmountStringFinalIdex - (i*3) -3;
    unprocessedAmount = "${unprocessedAmount.substring(0, ourCurrentIndex + 1)},${unprocessedAmount.substring(ourCurrentIndex+1)}";
  }
  return "Ksh. $unprocessedAmount.00";
}