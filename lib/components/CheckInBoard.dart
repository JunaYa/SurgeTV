// 签到板
import 'package:flutter/material.dart';

class CheckInBoard extends StatefulWidget {
  const CheckInBoard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CheckInBoardState();
  }
}

class _CheckInBoardState extends State<CheckInBoard> {
  List<Map<String, dynamic>> rewardMap = <Map<String, dynamic>>[
    {
      'day': '今天',
      'isSigned': false,
      'reward': 2,
      'isCurrent': true,
      'isToday': true,
    },
    {
      'day': '第2天',
      'isSigned': false,
      'reward': 3,
      'isCurrent': false,
      'isToday': false,
    },
    {
      'day': '第3天',
      'isSigned': false,
      'reward': 4,
      'isCurrent': false,
      'isToday': false,
    },
    {
      'day': '第4天',
      'isSigned': false,
      'reward': 5,
      'isCurrent': false,
      'isToday': false,
    },
    {
      'day': '第5天',
      'isSigned': false,
      'reward': 6,
      'isCurrent': false,
      'isToday': false,
    },
    {
      'day': '第6天',
      'isSigned': false,
      'reward': 7,
      'isCurrent': false,
      'isToday': false,
    },
    {
      'day': '第7天',
      'isSigned': false,
      'reward': 8,
      'isCurrent': false,
      'isToday': false,
    },
  ];

  // 今天是否已签到
  bool _isCheckedIn() {
    for (var day in rewardMap) {
      if (day['isToday'] == true) {
        return day['isSigned'] == true;
      }
    }
    return false;
  }

  // 连续签到天数
  int _getContinuousCheckInDays() {
    int count = 0;
    for (var day in rewardMap) {
      if (day['isToday'] == true) {
        count++;
      }
    }
    return count;
  }

  // 获取当前签到奖励
  int _getCurrentReward() {
    for (var day in rewardMap) {
      if (day['isToday'] == true) {
        return day['reward'] as int;
      }
    }
    return 0;
  }

  void _handleCheckIn() {
    // 已签到，不做处理
    if (_isCheckedIn()) {
      return;
    }
    // 找到今天未签到的，签到
    for (var day in rewardMap) {
      if (day['isToday'] == true) {
        day['isSigned'] = true;
      }
    }
    // 更新状态
    setState(() {
      rewardMap = rewardMap;
    });
    _showCheckInDialog(context, reward: _getCurrentReward());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: [
            Icon(Icons.currency_exchange, color: Colors.yellow, size: 16),
            SizedBox(width: 4),
            Text(
              'T币余额',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(width: 4),
            Text(
              '1000',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 连续签到
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 150, 150),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month,
                      color: Colors.yellow, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '连续签到${_getContinuousCheckInDays()}天',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 连续签到 7 天, use map ['今天', '第2天', '第3天', '第4天', '第5天', '第6天', '第7天']
                  ...rewardMap.map(
                    (day) => Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 12, bottom: 12),
                              decoration: BoxDecoration(
                                color: day['isCurrent'] == true
                                    ? Colors.orange
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.yellow),
                                  const SizedBox(height: 4),
                                  Text("+2",
                                      style: TextStyle(
                                          color: day['isCurrent'] == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(day['day'] as String,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(left: 36, right: 36),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _handleCheckIn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 69, 59),
                  ),
                  child: Text(
                    _isCheckedIn() ? '看视频再得2币' : '立即签到',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}

_showCheckInDialog(BuildContext context, {required int reward}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                //
                SizedBox(
                  height: 240,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 138, 138),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 24),
                        Text(
                          '恭喜获得${reward}T币',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 38),
                        Container(
                          padding: const EdgeInsets.only(left: 36, right: 36),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 69, 59),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_camera_back,
                                    color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  '再得2币',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -120,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/icons/icon_checkin_success.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // close icon button
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
