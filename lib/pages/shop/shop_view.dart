import 'package:flutter/material.dart';
import 'package:surgetv/components/GradientButton.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'shop_logic.dart';

class ShopItemType {
  static const int normal = 2;
  static const int vip = 1;
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ShopLogic>();
    final state = Get.find<ShopLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(i18n.shop),
        ),
        body: state.loading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Featured Items Grid Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: state
                                .productList.length, // Number of grid items
                            itemBuilder: (context, index) {
                              // 普通商品
                              if (state.productList[index].type ==
                                  ShopItemType.normal) {
                                return ShopItem(
                                  price:
                                      '${state.productList[index].price}${state.productList[index].currency}',
                                  tips: '仅限一次',
                                  benefit:
                                      '${state.productList[index].coinNum}币',
                                  selected: state.currentSelect == index,
                                  onPressed: () {
                                    state.currentSelect.value = index;
                                  },
                                );
                              }
                              // vip商品
                              if (state.productList[index].type ==
                                  ShopItemType.vip) {
                                return ShopVipItem(
                                  name: state.productList[index].name,
                                  price:
                                      '${state.productList[index].price}${state.productList[index].currency}',
                                  benefit: '30天全场免费看',
                                  selected: state.currentSelect == index,
                                  onPressed: () {
                                    state.currentSelect.value = index;
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    // 立即充值按钮
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: GradientButton(
                        onPressed: () {},
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 230, 45, 32),
                            Color.fromARGB(255, 233, 40, 88),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: const Text(
                          '立即充值',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // 开通前请阅读
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: const Text(
                        '开通前请阅读《会员服务协议》及《自动续费付费规则》',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 充值声明

                    const RechargeDeclaration(),
                  ],
                ),
              ),
      ),
    );
  }
}

// 会员元素
// 名称： 月度会员 年度会员
// 价格： 12元 120元
// 权益： 30天全场免费看，365天全场免费看
class ShopVipItem extends StatelessWidget {
  final bool selected;
  final String name;
  final String price;
  final String benefit;
  final Function() onPressed;
  const ShopVipItem(
      {super.key,
      required this.name,
      required this.price,
      required this.benefit,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 230, 45, 32),
                    Color.fromARGB(255, 233, 40, 88),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 242, 219, 47),
                    Color.fromARGB(255, 242, 219, 47),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 233, 184, 50),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                benefit,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.price,
    required this.benefit,
    required this.selected,
    required this.onPressed,
    this.tips,
  });

  final bool selected;
  final String? tips;
  final String price;
  final String benefit;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 230, 45, 32),
                    Color.fromARGB(255, 233, 40, 88),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 242, 219, 47),
                    Color.fromARGB(255, 242, 219, 47),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              benefit,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            Text(
                              "+180币",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      price,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              ),
              tips != null
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 4,
                          bottom: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          tips ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

// 充值声明
// 1.月度会员和年度会员均支持自动续费，续费周期为1个月或1年。自动扣费用户可以在 App Store 中关闭自动续费。
// 2.T 币值可解锁单集视频，解锁价格以具体视频为准，。
// 3.VIP 可解锁全集视频，会员有效期内免费观看。会员到期后以 T 币值解锁。
// 4.充值所有内容为虚拟物品，不支持退款。

// 开通前请阅读《会员服务协议》及《自动续费付费规则》
class RechargeDeclaration extends StatelessWidget {
  const RechargeDeclaration({super.key});

  static const list = [
    '充值声明:',
    '1.月度会员和年度会员均支持自动续费，续费周期为1个月或1年。自动扣费用户可以在 App Store 中关闭自动续费。',
    '2.T 币值可解锁单集视频，解锁价格以具体视频为准。',
    '3.VIP 可解锁全集视频，会员有效期内免费观看。会员到期后以 T 币值解锁。',
    '4.充值所有内容为虚拟物品，不支持退款。',
  ];
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          height: 1.5,
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list.map((e) => Text(e, style: textStyle)).toList(),
      ),
    );
  }
}
