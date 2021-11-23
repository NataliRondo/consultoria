import 'package:consultoria/app/data/repositories_imp/account_repository_impl.dart';
import 'package:consultoria/app/data/repositories_imp/authentication_repository_imp.dart';
import 'package:consultoria/app/data/repositories_imp/sign_up_repository_imp.dart';
import 'package:consultoria/app/domain/repositories/account_repository.dart';
import 'package:consultoria/app/domain/repositories/authentication_repository.dart';
import 'package:consultoria/app/domain/repositories/sign_up_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meedu/meedu.dart';

Future<void> injectDependencies() async{
  Get.i.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );
  Get.i.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
  Get.i.lazyPut<AccountRepository>(
    () => AccountRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
}
