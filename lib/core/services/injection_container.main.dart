part of 'injection_container.dart';

final sl = GetIt.instance;
final nfcManager = NfcManager.instance;

class InjectionContainer {
  static Future<void> init() async {
    await _initAuth();
    await _initNfcCards();
    await _initStaff();
    await _initParkingHistory();
  }

  static Future<void> _initAuth() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerFactory(
      () => AuthBloc(
        signInWithEmailPassword: sl(),
        signOut: sl(),
        getUserData: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => SignInWithEmailPassword(sl()),
    );

    sl.registerLazySingleton(
      () => SignOut(sl()),
    );

    sl.registerLazySingleton(
      () => GetUserData(sl()),
    );

    sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        sl(),
        sl(),
      ),
    );

    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        sl(),
        sl(),
      ),
    );

    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()),
    );

    sl.registerLazySingleton(() => FirebaseAuth.instance);

    sl.registerLazySingleton(() => FirebaseFirestore.instance);

    sl.registerLazySingleton(() => sharedPreferences);
  }

  static Future<void> _initNfcCards() async {
    sl.registerFactory(
      () => NfcCardsBloc(
        addNewNfcCard: sl(),
        changeCurrentNfcCardStatus: sl(),
        checkIfNfcAvailable: sl(),
        getCardInformation: sl(),
        getAllNfcCards: sl(),
        getAvailableNfcCards: sl(),
        getInUseNfcCards: sl(),
        getLostNfcCards: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => AddNewNfcCard(sl()),
    );

    sl.registerLazySingleton(
      () => ChangeCurrentNfcCardStatus(sl()),
    );

    sl.registerLazySingleton(
      () => CheckIfNfcAvailable(sl()),
    );

    sl.registerLazySingleton(
      () => GetCardInformation(sl()),
    );

    sl.registerLazySingleton(
      () => GetAllNfcCards(sl()),
    );

    sl.registerLazySingleton(
      () => GetAvailableNfcCards(sl()),
    );

    sl.registerLazySingleton(
      () => GetInUseNfcCards(sl()),
    );

    sl.registerLazySingleton(
      () => GetLostNfcCards(sl()),
    );

    sl.registerLazySingleton<NfcCardsRepo>(
      () => NfcCardsRepoImpl(sl()),
    );

    sl.registerLazySingleton<NfcCardsRemoteDataSource>(
      () => NfcCardsRemoteDataSourceImpl(sl(), sl(), sl(), sl()),
    );

    sl.registerLazySingleton(() => nfcManager);
  }

  static Future<void> _initStaff() async {
    sl.registerFactory(
      () => StaffBloc(
        getAllStaff: sl(),
        signUpStaffAccount: sl(),
        deleteStaffAccount: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => GetAllStaff(sl()),
    );

    sl.registerLazySingleton(
      () => SignUpStaffAccount(sl()),
    );

    sl.registerLazySingleton(
      () => DeleteStaffAccount(sl()),
    );

    sl.registerLazySingleton<StaffRepo>(
      () => StaffRepoImpl(sl()),
    );

    sl.registerLazySingleton<StaffRemoteDataSource>(
      () => StaffRemoteDataSourceImpl(sl(), sl(), sl()),
    );
  }

  static Future<void> _initParkingHistory() async {
    sl.registerFactory(
      () => ParkingHistoryBloc(initializeCamera: sl()),
    );

    sl.registerLazySingleton(
      () => InitializeCamera(sl()),
    );

    sl.registerLazySingleton<ParkingHistoryRepo>(
      () => ParkingHistoryRepoImpl(sl()),
    );

    sl.registerLazySingleton<ParkingHistoryRemoteDataSource>(
      () => ParkingHistoryRemoteDataSourceImpl(sl(), sl()),
    );
  }
}
