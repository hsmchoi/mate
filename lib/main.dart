import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math'; // For Random data example
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle
// import 'package:intl/intl.dart'; // 날짜 포맷팅 위해 필요 (DartPad에서는 기본 제공 안 될 수 있음)

// --- 색상 정의 (동일) ---
const Color primaryColor = Color(0xFF5E81AC);
const Color secondaryColor = Color(0xFF88C0D0);
const Color accentColor = Color(0xFFBF616A);
const Color backgroundColorLight = Color(0xFFECEFF4);
const Color surfaceColorLight = Color(0xFFFFFFFF);
const Color textColorPrimaryLight = Color(0xFF2E3440);
const Color textColorSecondaryLight = Color(0xFF4C566A);
const Color successColor = Color(0xFFA3BE8C);
const Color warningColor = Color(0xFFD08770);
const Color surfaceColorLightEmphasis = Color(0xFFFAFAFA);

// --- 폰트 정의 (동일) ---
final String? fontFamilyTitle = GoogleFonts.montserrat().fontFamily;
final String? fontFamilyBody = GoogleFonts.lato().fontFamily;
final String? fontFamilyButton = GoogleFonts.openSans().fontFamily;

// --- 앱 테마 정의 (동일) ---
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColorLight,
  cardColor: surfaceColorLight,
  hintColor: secondaryColor,
  dividerColor: Colors.grey.shade300,
  textTheme: GoogleFonts.latoTextTheme(
    ThemeData.light().textTheme,
  ).copyWith(
    headlineSmall: TextStyle(fontFamily: fontFamilyTitle, color: textColorPrimaryLight, fontWeight: FontWeight.bold, fontSize: 22),
    titleLarge: TextStyle(fontFamily: fontFamilyTitle, color: textColorPrimaryLight, fontWeight: FontWeight.bold, fontSize: 18),
    titleMedium: TextStyle(fontFamily: fontFamilyTitle, color: textColorPrimaryLight, fontWeight: FontWeight.w600, fontSize: 16),
    bodyLarge: TextStyle(fontFamily: fontFamilyBody, color: textColorPrimaryLight, fontSize: 16),
    bodyMedium: TextStyle(fontFamily: fontFamilyBody, color: textColorSecondaryLight, fontSize: 14),
    bodySmall: TextStyle(fontFamily: fontFamilyBody, color: textColorSecondaryLight, fontSize: 12),
    labelLarge: TextStyle(fontFamily: fontFamilyButton, color: surfaceColorLight, fontWeight: FontWeight.w600, fontSize: 15),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColorLight,
    foregroundColor: textColorPrimaryLight,
    elevation: 0,
    titleTextStyle: TextStyle(fontFamily: fontFamilyTitle, color: textColorPrimaryLight, fontSize: 18, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: textColorPrimaryLight),
    surfaceTintColor: Colors.transparent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surfaceColorLight,
    selectedItemColor: primaryColor,
    unselectedItemColor: textColorSecondaryLight,
    selectedLabelStyle: TextStyle(fontFamily: fontFamilyBody, fontSize: 12),
    unselectedLabelStyle: TextStyle(fontFamily: fontFamilyBody, fontSize: 12),
    type: BottomNavigationBarType.fixed,
    elevation: 8.0,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: surfaceColorLight,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: surfaceColorLight,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: TextStyle(
        fontFamily: fontFamilyButton,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: surfaceColorLight,
      textStyle: TextStyle(fontFamily: fontFamilyButton, fontWeight: FontWeight.w600, fontSize: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      minimumSize: const Size(64, 48),
    ),
  ),
   listTileTheme: ListTileThemeData(
    iconColor: textColorSecondaryLight,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
  ),
  dividerTheme: DividerThemeData(
    space: 1,
    thickness: 1,
    indent: 16,
    endIndent: 16,
    color: Colors.grey.shade300,
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      background: backgroundColorLight,
      surface: surfaceColorLight,
      onPrimary: surfaceColorLight,
      onSecondary: textColorPrimaryLight,
      onSurface: textColorPrimaryLight,
      onError: surfaceColorLight,
      error: accentColor,
  ),
);

// --- 앱 진입점 (동일) ---
void main() {
  runApp(const SleepHealthApp());
}

class SleepHealthApp extends StatelessWidget {
  const SleepHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '꿀잠 앱 (가칭)',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

// --- 메인 화면 (하단 탭 네비게이션 포함 - 동일) ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 모든 탭 화면 위젯 리스트
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const RecordsScreen(), // 실제 RecordsScreen 위젯 사용
    const StatsScreen(), // 실제 StatsScreen 위젯 사용
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.notes_outlined), activeIcon: Icon(Icons.notes), label: '기록'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: '통계'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: '설정'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // 기록 화면에서도 작성 버튼이 필요할 수 있음
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                 // TODO: 현재 탭에 맞는 빠른 기록/작성 기능 구현
                 String message = _selectedIndex == 0 ? '빠른 기록' : '새 기록 작성';
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$message 기능 구현 예정')),
                );
              },
              tooltip: _selectedIndex == 0 ? '빠른 기록' : '새 기록 작성',
              child: const Icon(Icons.add),
            )
          : null,
       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// --- 홈 화면 (스크린 3 - 이전 단계와 동일) ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> { /* ... 이전 HomeScreen State 로직 동일 ... */
   String userName = "꿀잠러";
  double sleepGoalProgress = Random().nextDouble();
  String wakeUpGoal = "07:00 AM";
  String sleepGoal = "11:00 PM";
  String sleepTipTitle = "수면 환경 점검하기 🛌";
  String sleepTipContent = "침실은 최대한 어둡고, 조용하며, 약간 서늘한 온도를 유지하는 것이 숙면에 도움이 됩니다. 암막 커튼이나 귀마개를 활용해보세요.";
  late List<Map<String, dynamic>> _routines;
   @override void initState() { super.initState(); _routines = [ {'id': 1, 'icon': Icons.directions_walk, 'title': '저녁 산책', 'time': '오후 7:00', 'done': false}, {'id': 2, 'icon': Icons.no_food_outlined, 'title': '카페인 섭취 제한', 'time': '오후 7:00 부터', 'done': false}, {'id': 3, 'icon': Icons.phone_android_outlined, 'title': '스마트폰 사용 중단', 'time': '오후 10:00', 'done': false}, {'id': 4, 'icon': Icons.bathtub_outlined, 'title': '따뜻한 샤워', 'time': '오후 10:15', 'done': false}, {'id': 5, 'icon': Icons.book_outlined, 'title': '독서 또는 명상', 'time': '오후 10:45', 'done': false}, ]; }
  void _toggleRoutineDone(int id) { setState(() { final index = _routines.indexWhere((r) => r['id'] == id); if (index != -1) { _routines[index]['done'] = !_routines[index]['done']; ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text('${_routines[index]['title']} 상태 변경됨'), duration: const Duration(seconds: 1), ), ); } }); }
  @override Widget build(BuildContext context) { final theme = Theme.of(context); final now = DateTime.now(); final greeting = _getGreeting(now.hour, userName); return Scaffold( body: SafeArea( child: ListView( padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), children: [ Padding( padding: const EdgeInsets.only(bottom: 20.0), child: Text(greeting, style: theme.textTheme.headlineSmall), ), _buildSleepGoalCardDetailed(context, sleepGoalProgress, wakeUpGoal, sleepGoal), const SizedBox(height: 24), _buildSectionTitle(context, "오늘의 수면 루틴 🗓️", () { ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('전체 활동 보기 기능 구현 예정')), ); }), const SizedBox(height: 16), _buildRoutineListDetailed(context, _routines, _toggleRoutineDone), const SizedBox(height: 24), _buildSleepTipCardDetailed(context, sleepTipTitle, sleepTipContent), const SizedBox(height: 24), const SizedBox(height: 80), ], ), ), ); }
  String _getGreeting(int hour, String name) { /* ... */ if (hour < 5) return "$name님, 편안한 밤 보내세요 🌃"; if (hour < 12) return "$name님, 좋은 아침! ☀️"; if (hour < 18) return "$name님, 오후도 활기차게! 😊"; return "$name님, 편안한 저녁 시간 되세요 🌙"; }
  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onViewAll) { /* ... */ final theme = Theme.of(context); return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [ Text(title, style: theme.textTheme.titleLarge), TextButton(onPressed: onViewAll, child: const Text('전체 보기')), ], ); }
  Widget _buildSleepGoalCardDetailed(BuildContext context, double progress, String wakeUpGoal, String sleepGoal) { /* ... */ final theme = Theme.of(context); final String progressText = "${(progress * 100).toInt()}%"; return Card( color: primaryColor, child: InkWell( onTap: () {}, borderRadius: BorderRadius.circular(12), child: Padding( padding: const EdgeInsets.all(20.0), child: Row( children: [ Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text('오늘의 수면 목표', style: theme.textTheme.bodyMedium?.copyWith(color: surfaceColorLight.withOpacity(0.9), fontWeight: FontWeight.w500)), const SizedBox(height: 12), Row(children: [Icon(Icons.wb_sunny_outlined, color: surfaceColorLight.withOpacity(0.9), size: 18), const SizedBox(width: 8), Text('기상: $wakeUpGoal', style: theme.textTheme.bodyLarge?.copyWith(color: surfaceColorLight, fontWeight: FontWeight.w500))]), const SizedBox(height: 4), Row(children: [Icon(Icons.bedtime_outlined, color: surfaceColorLight.withOpacity(0.9), size: 18), const SizedBox(width: 8), Text('취침: $sleepGoal', style: theme.textTheme.bodyLarge?.copyWith(color: surfaceColorLight, fontWeight: FontWeight.w500))]), ], ), ), const SizedBox(width: 16), SizedBox( width: 70, height: 70, child: Stack(alignment: Alignment.center, children: [CircularProgressIndicator(value: progress, strokeWidth: 6, backgroundColor: surfaceColorLight.withOpacity(0.3), valueColor: const AlwaysStoppedAnimation<Color>(surfaceColorLight)), Text(progressText, style: theme.textTheme.labelLarge?.copyWith(fontSize: 14, color: surfaceColorLight))]), ), ], ), ), ), ); }
  Widget _buildRoutineListDetailed(BuildContext context, List<Map<String, dynamic>> routines, Function(int) onToggleDone) { /* ... */ return SizedBox( height: 140, child: ListView.builder( scrollDirection: Axis.horizontal, itemCount: routines.length, itemBuilder: (context, index) { final routine = routines[index]; return _buildRoutineItemDetailed(context, routine['icon'], routine['title'], routine['time'], routine['done'], () => onToggleDone(routine['id'])); }, ), ); }
  Widget _buildRoutineItemDetailed(BuildContext context, IconData icon, String title, String time, bool isDone, VoidCallback onTap) { /* ... */ final theme = Theme.of(context); return Card( margin: const EdgeInsets.only(right: 12), elevation: isDone ? 0.5 : 1.5, color: isDone ? surfaceColorLight.withOpacity(0.7) : surfaceColorLight, child: InkWell( onTap: onTap, borderRadius: BorderRadius.circular(12), child: Container( width: 140, padding: const EdgeInsets.all(16.0), child: Column( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [ Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Icon(icon, color: isDone ? textColorSecondaryLight : primaryColor, size: 30), Icon( isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? successColor : textColorSecondaryLight.withOpacity(0.5), size: 22 ), ], ), const SizedBox(height: 12), Text( title, style: theme.textTheme.bodyMedium?.copyWith( fontWeight: FontWeight.w600, color: isDone ? textColorSecondaryLight : textColorPrimaryLight, decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none, ), maxLines: 2, overflow: TextOverflow.ellipsis, ), const Spacer(), Text( time, style: theme.textTheme.bodySmall?.copyWith(color: textColorSecondaryLight), ), ], ), ), ), ); }
  Widget _buildSleepTipCardDetailed(BuildContext context, String title, String content) { /* ... */ final theme = Theme.of(context); return Card( color: surfaceColorLight, elevation: 1.5, child: InkWell( onTap: () {}, borderRadius: BorderRadius.circular(12), child: Padding( padding: const EdgeInsets.all(16.0), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text( title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 16, color: textColorPrimaryLight, fontWeight: FontWeight.w600)), const SizedBox(height: 10), Text( content, style: theme.textTheme.bodyMedium?.copyWith(color: textColorPrimaryLight, height: 1.5)), const SizedBox(height: 10), Align( alignment: Alignment.centerRight, child: TextButton( onPressed: () {}, child: const Text('더 알아보기'))), ], ), ), ), ); }

}


// --- 기록 화면 (스크린 UI 구현) ---
class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  // 더미 기록 데이터 (추후 상태 관리 및 로컬 저장소 연동)
  final List<Map<String, dynamic>> _sleepRecords = List.generate(10, (index) {
    final date = DateTime.now().subtract(Duration(days: index));
    final sleepDuration = Duration(hours: 7 + Random().nextInt(2), minutes: Random().nextInt(60));
    return {
      'date': date,
      'sleepTime': TimeOfDay(hour: 22 + Random().nextInt(2), minute: Random().nextInt(60)),
      'wakeUpTime': TimeOfDay.fromDateTime(date.add(sleepDuration)), // Approximation
      'duration': "${sleepDuration.inHours}시간 ${sleepDuration.inMinutes.remainder(60)}분",
      'quality': ['개운함 😊', '보통 🙂', '피곤함 😴'][Random().nextInt(3)],
      'diary': index % 3 == 0 ? '오늘은 꿈을 많이 꾼 것 같다. 어제 저녁 운동이 효과가 있었나?' : null, // 가끔 일기 있음
    };
  });

  // 날짜 포맷 함수 (intl 패키지 없이 간단 구현)
  String _formatDate(DateTime date) {
     const List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
     // 예: 10월 27일 (토)
     return "${date.month}월 ${date.day}일 (${weekdays[date.weekday - 1]})";
  }
   // 시간 포맷 함수
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod; // 0시는 12시로
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? '오전' : '오후';
    return "$period $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 수면 기록'),
        // TODO: 캘린더 아이콘 추가 -> 날짜 선택 기능
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            tooltip: '날짜 선택',
            onPressed: () {
              // TODO: 캘린더 표시 및 날짜 선택 기능 구현
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('캘린더 날짜 선택 기능 구현 예정')),
                );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0), // 리스트 주변 패딩
        itemCount: _sleepRecords.length,
        itemBuilder: (context, index) {
          final record = _sleepRecords[index];
          final date = record['date'] as DateTime;
          final sleepTime = record['sleepTime'] as TimeOfDay;
          final wakeUpTime = record['wakeUpTime'] as TimeOfDay;

          return Card(
             margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0), // 카드 간 간격
             child: ListTile(
               contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // ListTile 내부 패딩
               leading: Column( // 날짜 표시
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(date.day.toString(), style: theme.textTheme.titleLarge?.copyWith(color: primaryColor)),
                   Text('${date.month}월 (${['월', '화', '수', '목', '금', '토', '일'][date.weekday - 1]})', style: theme.textTheme.bodySmall),
                 ],
               ),
               title: Text( // 수면 시간 및 총 시간
                   '${_formatTime(sleepTime)} - ${_formatTime(wakeUpTime)} (${record['duration']})',
                   style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)
               ),
               subtitle: Column( // 수면 질 및 일기 요약
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(height: 4),
                   Text('수면 만족도: ${record['quality']}', style: theme.textTheme.bodyMedium),
                   if (record['diary'] != null) ...[ // 일기가 있을 경우 표시
                      const SizedBox(height: 4),
                      Text(
                        '일기: ${record['diary']}',
                        style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                   ]
                 ],
               ),
               trailing: const Icon(Icons.chevron_right, color: textColorSecondaryLight), // 상세 보기 표시
               onTap: () {
                 // TODO: 해당 날짜의 상세 기록 화면으로 이동 (스크린 56 연동)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${_formatDate(date)} 상세 기록 보기 구현 예정')),
                  );
               },
             ),
          );
        },
      ),
       floatingActionButton: FloatingActionButton( // 기록 화면용 FAB
              onPressed: () {
                // TODO: 새 수면 기록 작성 화면으로 이동
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('새 수면 기록 작성 화면 구현 예정')),
                );
              },
              tooltip: '새 수면 기록',
              child: const Icon(Icons.edit_note), // 아이콘 변경
        ),
    );
  }
}

// --- 통계 화면 (스크린 UI 구현) ---
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  // 더미 통계 데이터 (추후 상태 관리 및 계산 로직 필요)
  final String avgSleepDuration = "7시간 15분";
  final double weeklyGoalRate = 0.78; // 78%
  final String avgSleepQuality = "보통 🙂";
  final String consistencyScore = "65점"; // 수면 규칙성 점수 (가상)

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('수면 통계'),
         actions: [
          // TODO: 기간 선택 필터 (주간/월간/연간) 추가
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: '기간 선택',
            onSelected: (String result) {
              // TODO: 선택된 기간에 따라 통계 데이터 업데이트
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$result 통계 보기 구현 예정')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: '주간', child: Text('주간 통계')),
              const PopupMenuItem<String>(value: '월간', child: Text('월간 통계')),
              const PopupMenuItem<String>(value: '연간', child: Text('연간 통계')),
            ],
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text("최근 7일 데이터 요약", style: theme.textTheme.titleLarge), // 기간 표시 (동적으로 변경 필요)
          const SizedBox(height: 16),

          // 주요 통계 카드 그리드 (2x2 형태)
          GridView.count(
            crossAxisCount: 2, // 한 줄에 2개
            shrinkWrap: true, // 내용물 크기에 맞게 높이 조절
            physics: const NeverScrollableScrollPhysics(), // ListView 내부 스크롤 방지
            childAspectRatio: 1.2, // 카드 가로세로 비율 조정
            mainAxisSpacing: 12.0, // 수직 간격
            crossAxisSpacing: 12.0, // 수평 간격
            children: [
              _buildStatCard(context, Icons.hourglass_bottom_outlined, '평균 수면 시간', avgSleepDuration),
              _buildStatCard(context, Icons.check_circle_outline, '주간 목표 달성률', "${(weeklyGoalRate * 100).toInt()}%", highlightColor: successColor),
              _buildStatCard(context, Icons.sentiment_satisfied_alt_outlined, '평균 수면 만족도', avgSleepQuality),
              _buildStatCard(context, Icons.schedule_outlined, '수면 규칙성 점수', consistencyScore, highlightColor: secondaryColor),
            ],
          ),
          const SizedBox(height: 24),

          // TODO: 차트/그래프 영역 추가
          Text("수면 시간 추이 (그래프 구현 예정)", style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          Container( // 그래프 영역 Placeholder
            height: 200,
            decoration: BoxDecoration(
               color: surfaceColorLight,
               borderRadius: BorderRadius.circular(12),
               border: Border.all(color: theme.dividerColor)
            ),
            child: Center(child: Text("주간/월간 수면 시간 그래프 영역", style: theme.textTheme.bodyMedium)),
          ),
           const SizedBox(height: 24),
            Text("수면 만족도 분포 (그래프 구현 예정)", style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
           Container( // 그래프 영역 Placeholder
            height: 150,
            decoration: BoxDecoration(
               color: surfaceColorLight,
               borderRadius: BorderRadius.circular(12),
               border: Border.all(color: theme.dividerColor)
            ),
            child: Center(child: Text("수면 만족도 비율 원형/막대 그래프 영역", style: theme.textTheme.bodyMedium)),
          ),

        ],
      ),
    );
  }

  // 통계 카드 위젯 빌더
  Widget _buildStatCard(BuildContext context, IconData icon, String title, String value, {Color? highlightColor}) {
     final theme = Theme.of(context);
     final color = highlightColor ?? primaryColor;
     return Card(
       elevation: 1.5,
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소 간 공간 배분
           children: [
             Icon(icon, size: 32, color: color),
             // const SizedBox(height: 8),
             Column( // 텍스트 그룹
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                 const SizedBox(height: 4),
                 Text(
                    value,
                    style: theme.textTheme.headlineSmall?.copyWith(color: color, fontSize: 20, fontWeight: FontWeight.bold) // 값 강조
                 ),
               ],
             ),
           ],
         ),
       ),
     );
  }
}


// --- 설정 화면 (스크린 59 Profile - 이전 단계와 동일) ---
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> { /* ... 이전 SettingsScreen State 로직 동일 ... */
   final String userName = "꿀잠러버"; final String statusMessage = "오늘도 숙면 성공! ✨"; final String profileImageUrl = ''; final String wakeUpGoal = "07:00 AM"; final String sleepGoal = "11:00 PM"; final double weeklyGoalAchievedRate = 0.85;
  @override Widget build(BuildContext context) { final theme = Theme.of(context); return Scaffold( backgroundColor: backgroundColorLight, body: CustomScrollView( slivers: [ SliverAppBar( expandedHeight: 220.0, floating: false, pinned: true, backgroundColor: Colors.transparent, surfaceTintColor: primaryColor, elevation: 0, foregroundColor: surfaceColorLight, iconTheme: const IconThemeData(color: surfaceColorLight), actionsIconTheme: const IconThemeData(color: surfaceColorLight), flexibleSpace: FlexibleSpaceBar( centerTitle: false, title: Text(userName, style: theme.textTheme.titleLarge?.copyWith(color: textColorPrimaryLight, fontWeight: FontWeight.bold)), titlePadding: const EdgeInsetsDirectional.only(start: 72, bottom: 16), background: Container( decoration: BoxDecoration( gradient: LinearGradient( colors: [primaryColor.withOpacity(0.8), primaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight, ), ), child: Padding( padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight, bottom: 20), child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ CircleAvatar( radius: 45, backgroundColor: surfaceColorLight.withOpacity(0.9), child: profileImageUrl.isEmpty ? Text(userName.isNotEmpty ? userName[0].toUpperCase() : '?', style: theme.textTheme.headlineMedium?.copyWith(color: primaryColor)) : ClipOval(child: Image.network('https://via.placeholder.com/150', fit: BoxFit.cover))), const SizedBox(height: 12), Text( userName, style: theme.textTheme.headlineSmall?.copyWith(color: surfaceColorLight, fontSize: 20), ), const SizedBox(height: 6), Text( statusMessage, style: theme.textTheme.bodyMedium?.copyWith(color: surfaceColorLight.withOpacity(0.9)), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, ), ], ), ), ), ), actions: [ IconButton( icon: const Icon(Icons.edit_outlined), tooltip: '프로필 수정', onPressed: () { ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('프로필 수정 화면 구현 예정')), ); }, ), ], systemOverlayStyle: const SystemUiOverlayStyle( statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light, ), ), SliverPadding( padding: const EdgeInsets.only(top: 16.0), sliver: SliverList( delegate: SliverChildListDelegate( [ _buildInfoCard(context, '수면 목표', '기상 $wakeUpGoal / 취침 $sleepGoal', Icons.flag_outlined, () {}), _buildInfoCard(context, '주간 달성률', '${(weeklyGoalAchievedRate * 100).toInt()}%', Icons.check_circle_outline, () {}, highlightColor: successColor), const SizedBox(height: 8), const Divider(), _buildSettingsListTile(context, Icons.analytics_outlined, '수면 통계 및 분석', () {}), _buildSettingsListTile(context, Icons.note_alt_outlined, '나의 수면 일기 모아보기', () {}), _buildSettingsListTile(context, Icons.bookmark_border_outlined, '나중에 보기', () {}), const Divider(), _buildSettingsListTile(context, Icons.notifications_outlined, '알림 설정', () {}), _buildSettingsListTile(context, Icons.settings_outlined, '앱 환경 설정', () {}), _buildSettingsListTile(context, Icons.shield_outlined, '계정 및 개인정보', () {}), const Divider(), _buildSettingsListTile(context, Icons.star_border_outlined, '프리미엄 기능', () {}), _buildSettingsListTile(context, Icons.help_outline, '도움말 및 고객지원', () {}), _buildSettingsListTile(context, Icons.info_outline, '앱 정보', () {}), _buildSettingsListTile(context, Icons.logout, '로그아웃', () {}, color: accentColor), const SizedBox(height: 40), ], ), ), ), ], ), ); }
  Widget _buildInfoCard(BuildContext context, String title, String value, IconData icon, VoidCallback onTap, {Color? highlightColor}) { final theme = Theme.of(context); return Card( margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), elevation: 1, child: ListTile( leading: Icon(icon, color: highlightColor ?? primaryColor), title: Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)), subtitle: Text(value, style: theme.textTheme.bodyLarge?.copyWith(color: highlightColor ?? textColorPrimaryLight)), trailing: const Icon(Icons.chevron_right, color: textColorSecondaryLight), onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), ), ); }
  Widget _buildSettingsListTile(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color? color}) { final theme = Theme.of(context); final tileColor = color ?? theme.listTileTheme.iconColor; return ListTile( leading: Icon(icon, color: tileColor), title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(color: textColorPrimaryLight)), trailing: const Icon(Icons.chevron_right, color: textColorSecondaryLight), onTap: onTap ); }
}