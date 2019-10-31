import 'package:server/server.dart';

class User extends ManagedObject<_User> implements _User,ManagedAuthResourceOwner<_User>{
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition{

  @Column()
  int age;

  @Column()
  int sex;

  @Column(unique: true)
  String phone;
  @Column(unique: true)
  String email;

  @Column()
  double height;
  @Column()
  double weight;


  @Column()
  String state;
  @Column()
  String province;
  @Column()
  String city;
  @Column()
  String address;

}
