final String tableStudAcc = 'studAcc';

class StudAccFields{
  static final List<String>values= [
     studNum, lastName,firstName,middleName,balance
  ];

  static final String studNum='_studNum';
  static final String lastName='_lastName';
  static final String firstName='_firstName';
  static final String middleName='_middleName';
  static final String balance='_balance';
}

class StudAcc{
  final String studNum;
  final String lastName;
  final String firstName;
  final String? middleName;
  final int balance;

  const StudAcc({
    required this.studNum,
    required this.lastName,
    required this.firstName,
    this.middleName,
    required this.balance,
  });

  StudAcc copy({
    String? studNum,
    String? lastName,
    String? firstName,
    String? middleName,
    int? balance,
  })=>
      StudAcc(
        studNum: studNum?? this.studNum,
        lastName: lastName?? this.lastName,
        firstName: firstName?? this.firstName,
        middleName:  middleName?? this.middleName,
        balance: balance?? this.balance,
      );

  static StudAcc fromJson(Map<String,Object?>json)=> StudAcc(
    studNum: json[StudAccFields.studNum] as String,
    lastName: json[StudAccFields.lastName] as String,
    firstName: json[StudAccFields.firstName] as String,
    middleName: json[StudAccFields.middleName] as String,
    balance: json[StudAccFields.balance] as int,
  );

  Map<String, Object?> toJson()=>{
    StudAccFields.studNum: studNum,
    StudAccFields.lastName: lastName,
    StudAccFields.firstName: firstName,
    StudAccFields.middleName: middleName,
    StudAccFields.balance: balance,
  };


}