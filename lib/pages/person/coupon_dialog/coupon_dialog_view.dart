// coupon_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'coupon_dialog_logic.dart';

class CouponDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<CouponDialogLogic>();
    final state = Bind.find<CouponDialogLogic>().state;
    final i18n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Row(
              children: [
                Text(
                  i18n.exchangeExclusiveDiscount,
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                // 关闭按钮
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 描述文本
            Text(
              i18n.pleaseEnter + i18n.couponCode,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),

            const SizedBox(height: 24),

            // 输入框
            TextField(
              controller: logic.controller,
              decoration: InputDecoration(
                hintText: i18n.pleaseEnter + i18n.couponCode,
                errorText: state.errorText,
                prefixIcon: const Icon(Icons.card_giftcard),
                border: const OutlineInputBorder(),
                // 添加复制按钮
                suffixIcon: IconButton(
                  icon: const Icon(Icons.content_paste),
                  onPressed: () async {
                    final data = await Clipboard.getData('text/plain');
                    if (data?.text != null) {
                      logic.controller.text = data!.text!;
                    }
                  },
                  tooltip: i18n.pasteFromClipboard,
                ),
              ),
              // 自动大写
              textCapitalization: TextCapitalization.characters,
              // 输入限制
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9-]')),
                UpperCaseTextFormatter(),
              ],
              onSubmitted: (_) => logic.handleSubmit(),
            ),

            const SizedBox(height: 24),

            // 提交按钮
            FilledButton(
              onPressed: state.isSubmitting ? null : logic.handleSubmit,
              child: state.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(i18n.exchange),
            ),
          ],
        ),
      ),
    );
  }
}

// 输入格式化器：自动转换大写
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
