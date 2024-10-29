// coupon_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final String description;

  const CouponDialog({
    super.key,
    required this.onSubmit,
    this.description = '请输入优惠券序列号进行兑换，确保输入正确以避免兑换失败',
  });

  static Future<void> show({
    required BuildContext context,
    required Function(String) onSubmit,
    String? description,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CouponDialog(
        onSubmit: onSubmit,
        description: description ?? '请输入优惠券序列号进行兑换，确保输入正确以避免兑换失败',
      ),
    );
  }

  @override
  State<CouponDialog> createState() => _CouponDialogState();
}

class _CouponDialogState extends State<CouponDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;
  String? _errorText;

  // 验证输入的序列号格式
  bool _validateCode(String code) {
    // 这里添加你的验证逻辑，例如：
    // - 长度限制
    // - 字符要求
    // - 格式检查
    if (code.isEmpty) {
      setState(() => _errorText = '请输入优惠券序列号');
      return false;
    }
    if (code.length < 6) {
      setState(() => _errorText = '序列号长度不能小于6位');
      return false;
    }
    setState(() => _errorText = null);
    return true;
  }

  // 处理提交
  Future<void> _handleSubmit() async {
    final code = _controller.text.trim();
    
    if (!_validateCode(code)) return;
    
    setState(() => _isSubmitting = true);
    
    try {
      await widget.onSubmit(code);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorText = e.toString();
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  '优惠券兑换',
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
              widget.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 输入框
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '请输入序列号',
                errorText: _errorText,
                prefixIcon: const Icon(Icons.card_giftcard),
                border: const OutlineInputBorder(),
                // 添加复制按钮
                suffixIcon: IconButton(
                  icon: const Icon(Icons.content_paste),
                  onPressed: () async {
                    final data = await Clipboard.getData('text/plain');
                    if (data?.text != null) {
                      _controller.text = data!.text!;
                    }
                  },
                  tooltip: '从剪贴板粘贴',
                ),
              ),
              // 自动大写
              textCapitalization: TextCapitalization.characters,
              // 输入限制
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9-]')),
                UpperCaseTextFormatter(),
              ],
              onSubmitted: (_) => _handleSubmit(),
            ),
            
            const SizedBox(height: 24),
            
            // 提交按钮
            FilledButton(
              onPressed: _isSubmitting ? null : _handleSubmit,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('立即兑换'),
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

// 使用示例
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  Future<void> _redeemCoupon(String code) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    if (code == 'TEST123') {
      throw '该优惠券已被使用';
    }
    // 处理兑换逻辑
    debugPrint('兑换成功：$code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('优惠券兑换示例')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            CouponDialog.show(
              context: context,
              onSubmit: _redeemCoupon,
              description: '输入您收到的优惠券序列号，兑换专属优惠。\n每个序列号仅能使用一次。',
            );
          },
          child: const Text('打开兑换弹窗'),
        ),
      ),
    );
  }
}