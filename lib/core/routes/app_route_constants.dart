enum AppPage {
  signIn,
  nfcCardsShell,
  allNfcCards,
  availableNfcCards,
  inUseNfcCards,
  lostNfcCards,
  scanNfc,
  scanLicensePlate,
  parkingHistoryShell,
  recentlyParkingHistory,
  oldestParkingHistory,
  detailInfoLicensePlate,
  staff,
  signUpStaffAccount,
  settings,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.signIn:
        return "/";
      case AppPage.nfcCardsShell:
        return "/nfc_cards_shell";
      case AppPage.allNfcCards:
        return "/all_nfc_cards";
      case AppPage.availableNfcCards:
        return "/available_nfc_cards";
      case AppPage.inUseNfcCards:
        return "/in_use_nfc_cards";
      case AppPage.lostNfcCards:
        return "/lost_nfc_cards";
      case AppPage.scanNfc:
        return "/scan_nfc";
      case AppPage.scanLicensePlate:
        return "/scan_license_plate";
      case AppPage.parkingHistoryShell:
        return "/parking_history_shell";
      case AppPage.recentlyParkingHistory:
        return "/recently_parking_history";
      case AppPage.oldestParkingHistory:
        return "/oldest_parking_history";
      case AppPage.detailInfoLicensePlate:
        return "/detail_info_license_plate";
      case AppPage.staff:
        return "/staff";
      case AppPage.signUpStaffAccount:
        return "/sign_up_staff_account";
      case AppPage.settings:
        return "/settings";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.signIn:
        return "SIGN_IN";
      case AppPage.nfcCardsShell:
        return "NFC_CARDS_SHELL";
      case AppPage.allNfcCards:
        return "ALL_NFC_CARDS";
      case AppPage.availableNfcCards:
        return "AVAILABLE_NFC_CARDS";
      case AppPage.inUseNfcCards:
        return "IN_USE_NFC_CARDS";
      case AppPage.lostNfcCards:
        return "LOST_NFC_CARDS";
      case AppPage.scanNfc:
        return "SCAN_NFC";
      case AppPage.scanLicensePlate:
        return "SCAN_LICENSE_PLATE";
      case AppPage.parkingHistoryShell:
        return "PARKING_HISTORY_SHELL";
      case AppPage.recentlyParkingHistory:
        return "RECENTLY_PARKING_HISTORY";
      case AppPage.oldestParkingHistory:
        return "OLDEST_PARKING_HISTORY";
      case AppPage.detailInfoLicensePlate:
        return "DETAIL_INFO_LICENSE_PLATE";
      case AppPage.staff:
        return "STAFF";
      case AppPage.signUpStaffAccount:
        return "SIGN_UP_STAFF_ACCOUNT";
      case AppPage.settings:
        return "SETTINGS";
      default:
        return "SIGN_IN";
    }
  }
}
