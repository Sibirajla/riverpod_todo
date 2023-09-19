
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo/common/helper/user/db_helper.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  Future <bool> build() async => DBHelper.userExists();

}