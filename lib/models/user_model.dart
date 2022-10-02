class UserModel{
  late String image;
  late String name;
  late String career;
  late int balance;
  late int totalIncome;
  late int totalSpending;

  //Normal constructor
  /*UserModel(){
  };*/

  //From all data filled
  UserModel.dataHandFilled(this.image, this.name, this.career, this.balance, this.totalIncome, this.totalSpending);

  //Constructor from json
  UserModel.fromJsonMap(Map<String, dynamic> user){
    image = user["img"];
    name = user["name"];
    career = user["career"];
    balance = int.parse(user["balance"]);
    totalIncome = int.parse(user["total_income"]);
    totalSpending = int.parse(user["total_spending"]);

  }
}