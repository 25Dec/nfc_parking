import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nfc_parking/core/enum/enum.dart';

import '../../../../core/res/app_colors.dart';
import '../../domain/entities/nfc_card_entity.dart';

class SlidableNfcCard extends StatelessWidget {
  final NfcCardEntity data;

  const SlidableNfcCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String cardStatus = data.cardStatus.name;

    if (cardStatus == NfcCardStatus.inUse.name) {
      cardStatus = "in use";
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        key: ValueKey(data),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => {},
              backgroundColor: AppColors.white3,
              foregroundColor: Colors.white,
              icon: FluentIcons.edit_16_regular,
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white6,
                    backgroundImage: AssetImage("assets/images/nfc_tag.png"),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: Text(
                    "ID: ${data.cardID}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: cardStatus == "available"
                              ? AppColors.green
                              : cardStatus == "in use"
                                  ? AppColors.yellow
                                  : AppColors.red,
                        ),
                      ),
                    ),
                    child: Text(
                      cardStatus.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: cardStatus == "available"
                            ? AppColors.green
                            : cardStatus == "in use"
                                ? AppColors.yellow
                                : AppColors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
