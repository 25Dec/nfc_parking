import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_route_constants.dart';
import '../../../../../core/utils/core_utils.dart';
import '../../../domain/entities/nfc_card_entity.dart';
import '../../bloc/nfc_cards_bloc.dart';
import '../../widgets/slidable_nfc_card.dart';

class LostNfcCardsPage extends StatefulWidget {
  const LostNfcCardsPage({super.key});

  @override
  State<LostNfcCardsPage> createState() => _LostNfcCardsPageState();
}

class _LostNfcCardsPageState extends State<LostNfcCardsPage> {
  @override
  void initState() {
    super.initState();
    getLostCards();
  }

  Future<void> getLostCards() async {
    BlocProvider.of<NfcCardsBloc>(context).add(
      GetLostNfcCardsEvent(),
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
        if (nfcCardsState is DoneGettingLostNfcCardsState) {
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
          onRefresh: getLostCards,
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
                            "assets/images/empty_cactus.jpg",
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "We Haven't Lost Any Cards Yet!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
