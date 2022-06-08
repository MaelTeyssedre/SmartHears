class AuthenticationRepository {
  String apiURL;
  // final _controller = StreamController<AuthenticationStatus>();
  // final _storage = FlutterSecureStorage();

  AuthenticationRepository(this.apiURL);

  // Stream<AuthenticationStatus> get status async* {
  //   if (await this.hasToken())
  //     yield AuthenticationStatus.authenticated;
  //   else
  //     yield AuthenticationStatus.unauthenticated;
  //   yield* _controller.stream;
  // }

  // Future<User> socialLoginOrRegister(
  //     {required String providerId,
  //     required String email,
  //     required String fcmToken,
  //     required String deviceId,
  //     required String phoneModel,
  //     required String sdkVersion,
  //     required String language,
  //     required String providerName,
  //     String? accessToken,
  //     String? refreshToken,
  //     String? displayName,
  //     String? firstname,
  //     String? lastname,
  //     String? picture}) async {
  //   var values =
  //       (await HttpHelpers().post(path: ApiPath.SOCIAL_AUTHENTICATION, body: {
  //     'profile': {
  //       'login': displayName != null ? displayName.replaceAll(' ', '_') : email,
  //       'email': email,
  //       'deviceId': deviceId,
  //       'platform': Platform.isIOS ? 'ios' : 'android',
  //       'fcmToken': fcmToken,
  //       'providerId': providerId,
  //       'providerName': providerName,
  //       'accessToken': accessToken != null ? accessToken : '',
  //       'refreshToken': refreshToken != null ? refreshToken : '',
  //       'displayName': displayName,
  //       'firstname': firstname,
  //       'lastname': lastname,
  //       'picture': picture
  //     },
  //     'info': {
  //       'deviceId': deviceId,
  //       'firebaseToken': fcmToken,
  //       'phoneModel': phoneModel,
  //       'sdkVersion': sdkVersion,
  //       'language': language,
  //       'application': 'fanartzone'
  //     }
  //   })) as Map<String, dynamic>;
  //   var user = User.fromJson(values['account']);
  //   this.persistToken(values['token']);
  //   return user;
  // }

  // Future<User> logIn(
  //     {required String username,
  //     required String password,
  //     required String fcmToken,
  //     required String deviceId,
  //     required String phoneModel,
  //     required String sdkVersion,
  //     required String language}) async {
  //   var values = (await HttpHelpers().post(path: ApiPath.AUTHENTICATE, body: {
  //     'login': username,
  //     'password': password,
  //     'fcmToken': fcmToken,
  //     'deviceId': deviceId,
  //     'phoneModel': phoneModel,
  //     'sdkVersion': sdkVersion,
  //     'language': language,
  //     'application': 'fanartzone'
  //   })) as Map<String, dynamic>;
  //   var user = User.fromJson(values['account']);
  //   this.persistToken(values['token']);
  //   return user;
  // }

  // Future<void> refreshToken() async => await this.persistToken(
  //     ((await HttpHelpers().get(path: ApiPath.REFRESH_TOKEN))
  //         as Map<String, dynamic>)['token']);

  // Future<void> goToChangePassword() async =>
  //     _controller.add(AuthenticationStatus.firstConnection);

  // Future<void> changePassword({required String password}) async {
  //   await HttpHelpers()
  //       .put(path: ApiPath.CHANGE_PASSWORD, body: {'password': password});
  //   _controller.add(AuthenticationStatus.authenticated);
  // }

  // Future<void> recoverPassword({required String login}) async =>
  //     await HttpHelpers()
  //         .post(path: ApiPath.RECOVER_PASSWORD, body: {'login': login});

  // Future<User> register(
  //     {required String username,
  //     required String password,
  //     required String email,
  //     required String deviceId,
  //     required String fcmToken,
  //     required String phoneModel,
  //     required String language,
  //     required String sdkVersion}) async {
  //   var values = (await HttpHelpers().post(path: ApiPath.REGISTER, body: {
  //     'login': username,
  //     'password': password,
  //     'email': email,
  //     'deviceId': deviceId,
  //     'platform': Platform.isIOS ? 'ios' : 'android',
  //     'fcmToken': fcmToken,
  //     'phoneModel': phoneModel,
  //     'language': language,
  //     'sdkVersion': sdkVersion,
  //     'application': 'fanartzone'
  //   })) as Map<String, dynamic>;
  //   _controller.add(AuthenticationStatus.authenticated);
  //   this.persistToken(values['token']);
  //   return User.fromJson(values);
  // }

  // Future<void> updateAccount(
  //     {required String firstname,
  //     required String lastname,
  //     required DateTime? birthdate,
  //     required String city,
  //     required String country,
  //     required String phone,
  //     required List<Favorite> clubs,
  //     required List<Favorite> sports,
  //     required List<Favorite> stars,
  //     required bool newsletter}) async {
  //   await HttpHelpers().put(path: ApiPath.ME_DETAILS, body: {
  //     'firstname': firstname,
  //     'lastname': lastname,
  //     'birthDate':
  //         (birthdate != null) ? birthdate.toString().substring(0, 10) : null,
  //     'city': city,
  //     'country': country,
  //     'phone': phone.substring(1, phone.length),
  //     'newsletter': newsletter,
  //     'clubs': clubs.map((e) => e.toJson(e)).toList(),
  //     'sports': sports.map((e) => e.toJson(e)).toList(),
  //     'stars': stars.map((e) => e.toJson(e)).toList()
  //   });
  //   _controller.add(AuthenticationStatus.authenticated);
  //   return;
  // }

  // void loginSuccess() => _controller.add(AuthenticationStatus.authenticated);

  // Future<bool> updateAvatar({required File file}) async {
  //   await HttpHelpers().uploadFile(uri: ApiPath.UPDATE_AVATAR, file: file);
  //   return true;
  // }

  // void logOut() {
  //   this.deleteToken();
  //   _controller.add(AuthenticationStatus.unauthenticated);
  // }

  // void dispose() => _controller.close();

  // Future<void> deleteToken() async {
  //   await _storage.delete(key: 'token');
  //   await _storage.delete(key: 'user');
  // }

  // Future<void> persistToken(String token) async {
  //   await _storage.write(key: 'token', value: token);
  //   await _storage.write(key: 'user', value: JwtDecoder.decode(token)['login']);
  // }

  // Future<bool> hasToken() async => (await _storage.read(key: 'token')) != null;

  // Future<String?> getToken() async => (await _storage.read(key: 'token'));

  // Future<String> getUser() async {
  //   var value = await _storage.read(key: 'user');
  //   if (value == null) {
  //     value =
  //         JwtDecoder.decode(await _storage.read(key: 'token') ?? '')['login'];
  //     if (value != null)
  //       await _storage.write(key: 'user', value: value);
  //     else
  //       _controller.add(AuthenticationStatus.unauthenticated);
  //   }
  //   return value ?? '';
  // }

  // Future<bool> isAdmin() async =>
  //     JwtDecoder.decode(await _storage.read(key: 'token') ?? '')['role'] ==
  //     'ADMIN';

  // Future<int> getId() async {
  //   var token = await _storage.read(key: 'token');
  //   if (token != null) return JwtDecoder.decode(token)['id'];
  //   return -1;
  // }

  // Future<bool> hasAccess(List<int> users) async {
  //   if (await this.isAdmin()) return true;
  //   if (users.length > 0)
  //     return users.indexOf(
  //             JwtDecoder.decode(await _storage.read(key: 'token') ?? '')['id']
  //                 as int) >=
  //         0;
  //   return false;
  // }

  // Future<String> getUserEmail() async =>
  //     JwtDecoder.decode(await _storage.read(key: 'token') ?? '')['email'];
}
