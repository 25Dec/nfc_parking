import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_text_button.dart';
import '../../../../../core/res/app_colors.dart';
import '../../../../../core/routes/app_route_constants.dart';
import '../../../../../core/utils/core_utils.dart';
import '../../../domain/entities/nfc_card_entity.dart';
import '../../bloc/nfc_cards_bloc.dart';
import '../../widgets/slidable_nfc_card.dart';

class AllNfcCardsPage extends StatefulWidget {
  const AllNfcCardsPage({super.key});

  @override
  State<AllNfcCardsPage> createState() => _AllNfcCardsPageState();
}

class _AllNfcCardsPageState extends State<AllNfcCardsPage> {
  @override
  void initState() {
    super.initState();
    getAllCards();
  }

  Future<void> getAllCards() async {
    BlocProvider.of<NfcCardsBloc>(context).add(
      GetAllNfcCardsEvent(),
    );
  }

  void onAddCard() {
    BlocProvider.of<NfcCardsBloc>(context).add(
      CheckIfNfcAvailableEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NfcCardEntity> cards = [];

    return BlocConsumer<NfcCardsBloc, NfcCardsState>(
      listener: (context, nfcCardsState) async {
        if (nfcCardsState is DoneGettingAllNfcCardsState) {
          cards = nfcCardsState.cards;
        }

        if (nfcCardsState is NfcAvailableState) {
          GoRouter.of(context).pushNamed(AppPage.scanNfc.toName);
        } else if (nfcCardsState is NfcNotAvailableState) {
          CoreUtils.showCustomDialog(
            context,
            title: "NFC Is Not Enabled!",
            content: "Please enable NFC to use this feature.",
            confirmText: "Confirm",
          );
        }
      },
      builder: (context, nfcCardsState) {
        return RefreshIndicator(
          onRefresh: getAllCards,
          child: Scaffold(
            body: cards.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (_, index) => SlidableNfcCard(
                        data: cards[index],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset(
                            "assets/images/empty_bird.jpg",
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "There Are No Cards Yet!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextButton(
                          onPressed: onAddCard,
                          text: "Click here to add a new card",
                          textColor: AppColors.green,
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
