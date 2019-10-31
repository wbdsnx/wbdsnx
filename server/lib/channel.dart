import 'server.dart';
import 'package:server/model/user.dart';
class ServerChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  @override
  Future prepare() async {
    final config =
        AppConfiguration.fromFile(File(options.configurationFilePath));
    final db = config.database;
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        db.username, db.password, db.host, db.port, db.databaseName);
    context = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    authServer = AuthServer(ManagedAuthDelegate<User>(context));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    return router;
  }
}

class AppConfiguration extends Configuration {
  AppConfiguration.fromFile(File file) : super.fromFile(file);

  DatabaseConfiguration database;
}
