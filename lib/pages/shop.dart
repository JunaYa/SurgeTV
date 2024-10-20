import 'package:flutter/material.dart';
import 'package:surgetv/components/GradientButton.dart';
import 'package:surgetv/dao/shop_dao.dart';
import 'package:surgetv/model/shop.dart';

class ShopItemType {
  static const int normal = 2;
  static const int vip = 1;
}

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _currentSelect = 0;

  // loading
  bool _loading = false;
  // 商品列表
  List<Product> _productList = [];

  void _getProductList() async {
    setState(() {
      _loading = true;
    });
    var res = await ShopDao.getProductList();
    if (res.result) {
      setState(() {
        _productList = res.data;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('商店'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              color: const Color.fromARGB(255, 33, 32, 32),
              child: SingleChildScrollView(
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
                            itemCount:
                                _productList.length, // Number of grid items
                            itemBuilder: (context, index) {
                              // 普通商品
                              if (_productList[index].type ==
                                  ShopItemType.normal) {
                                return ShopItem(
                                  price:
                                      '${_productList[index].price}${_productList[index].currency}',
                                  tips: '仅限一次',
                                  benefit: '${_productList[index].coinNum}币',
                                  selected: _currentSelect == index,
                                  onPressed: () {
                                    setState(() {
                                      _currentSelect = index;
                                    });
                                  },
                                );
                              }
                              // vip商品
                              if (_productList[index].type ==
                                  ShopItemType.vip) {
                                return ShopVipItem(
                                  name: _productList[index].name,
                                  price:
                                      '${_productList[index].price}${_productList[index].currency}',
                                  benefit: '30天全场免费看',
                                  selected: _currentSelect == index,
                                  onPressed: () {
                                    setState(() {
                                      _currentSelect = index;
                                    });
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
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '充值声明:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '1.月度会员和年度会员均支持自动续费，续费周期为1个月或1年。自动扣费用户可以在 App Store 中关闭自动续费。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '2.T 币值可解锁单集视频，解锁价格以具体视频为准，。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          // 3.
                          Text(
                            '3.VIP 可解锁全集视频，会员有效期内免费观看。会员到期后以 T 币值解锁。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          // 4.
                          Text(
                            '4.充值所有内容为虚拟物品，不支持退款。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 26, 25, 25),
                  borderRadius: BorderRadius.only(
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
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
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
                    : const Color.fromARGB(255, 50, 48, 48),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                benefit,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
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
              ? LinearGradient(
                  colors: [
                    Color.fromARGB(255, 230, 45, 32),
                    Color.fromARGB(255, 233, 40, 88),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
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
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 26, 25, 25),
                        borderRadius: BorderRadius.only(
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
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "+180币",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 233, 40, 88),
                                fontWeight: FontWeight.bold,
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
                          : const Color.fromARGB(255, 50, 48, 48),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 233, 40, 88),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          tips ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
