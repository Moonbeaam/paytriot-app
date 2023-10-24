final String tableStudAcc = 'studAcc';

class StudAccFields{
  static final List<String>values= [
    id, studNum, lastName,firstName,middleName,balance
  ];

  static final String id= '_id';
  static final String studNum='_studNum';
  static final String lastName='_lastName';
  static final String firstName='_firstName';
  static final String middleName='_middleName';
  static final String balance='_balance';
}

class StudAcc{
  final int? id;
  final String studNum;
  final String lastName;
  final String firstName;
  final String middleName;
  final int balance;

  const StudAcc({
    this.id,
    required this.studNum,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.balance,
  });

  StudAcc copy({
    int? id,
    String? studNum,
    String? lastName,
    String? firstName,
    String? middleName,
    int? balance,
  })=>
      StudAcc(
        id: id?? this.id,
        studNum: studNum?? this.studNum,
        lastName: lastName?? this.lastName,
        firstName: firstName?? this.firstName,
        middleName:  middleName?? this.middleName,
        balance: balance?? this.balance,
      );

  static StudAcc fromJson(Map<String,Object?>json)=> StudAcc(
    id: json[StudAccFields.id] as int?,
    studNum: json[StudAccFields.studNum] as String,
    lastName: json[StudAccFields.lastName] as String,
    firstName: json[StudAccFields.firstName] as String,
    middleName: json[StudAccFields.middleName] as String,
    balance: json[StudAccFields.balance] as int,
  );

  Map<String, Object?> toJson()=>{
    StudAccFields.id: id,
    StudAccFields.studNum: studNum,
    StudAccFields.lastName: lastName,
    StudAccFields.firstName: firstName,
    StudAccFields.middleName: middleName,
    StudAccFields.balance: balance,
  };


}