import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../features/nfc_cards/presentation/bloc/nfc_cards_bloc.dart';
import '../../enum/enum.dart';
import '../../res/app_colors.dart';
import '../../utils/core_utils.dart';

class ScanNfcPage extends StatefulWidget {
  const ScanNfcPage({super.key});

  @override
  State<ScanNfcPage> createState() => _ScanNfcPageState();
}

class _ScanNfcPageState extends State<ScanNfcPage> {
  void writeDataToNfcTag({required NfcTag tag}) {}

  @override
  void initState() {
    super.initState();

    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        BlocProvider.of<NfcCardsBloc>(context).add(
          GetCardInformationEvent(tag: tag),
        );

        final nfcCardsState = BlocProvider.of<NfcCardsBloc>(context).state;

        if (nfcCardsState is NfcCardDoesNotHaveDataState) {
          List<Map<String, dynamic>> dataForNfcCard = [
            {"cardID": const Uuid().v4().toString()},
            {"cardStatus": NfcCardStatus.available.name},
            {"createdAt": DateTime.now().toString()},
            {"updatedAt": null},
          ];

          NdefMessage message = NdefMessage(
            dataForNfcCard
                .map(
                  (row) => NdefRecord.createText(
                      '{"${row.keys.first}":"${row.values.first}"}'),
                )
                .toList(),
          );

          Ndef.from(tag)!.write(message);

          BlocProvider.of<NfcCardsBloc>(context).add(
            AddNewNfcCardEvent(tag: tag, data: dataForNfcCard),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return BlocListener<NfcCardsBloc, NfcCardsState>(
      listener: (context, nfcCardsState) async {
        if (nfcCardsState is NfcCardAlreadyHasDataState) {
          CoreUtils.showCustomDialog(
            context,
            title: "NFC Card Already Exists In The System!",
            content: "The system has registered this NFC card before.",
            confirmText: "Confirm",
          );
        }

        if (nfcCardsState is AddNewNfcCardSuccessfullyState) {
          CoreUtils.showCustomDialog(
            context,
            title: "NFC Card Added Successfully!",
            content: "The NFC card has been added to the system.",
            confirmText: "Confirm",
            onConfirm: () => GoRouter.of(context).pop(),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Ready to Write",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 24),
                const Icon(
                  Icons.nfc,
                  color: AppColors.green,
                  size: 140,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Hold your device near the NFC tag",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: deviceWidth - 32,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!context.mounted) return;
                      GoRouter.of(context).pop();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.gray,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        AppColors.black2,
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
