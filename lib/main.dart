import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math'; // For Random data example
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle
// import 'package:provider/provider.dart'; // 실제 프로젝트에서는 이 패키지를 import 해야 합니다.

// --- 데이터 모델 정의 ---

// 사용자 정보 모델
class UserData {
  final String name;
  final String statusMessage;
  final String profileImageUrl;
  final String wakeUpGoal; // 예: "HH:MM AM/PM"
  final String sleepGoal; // 예: "HH:MM AM/PM"

  UserData({
    required this.name,
    this.statusMessage = "",
    this.profileImageUrl = '',
    required this.wakeUpGoal,
    required this.sleepGoal,
  });
}

// 수면 루틴 모델
class Routine {
  final int id;
  final IconData icon;
  final String title;
  final String time;
  bool done; // 완료 여부 상태

  Routine({
    required this.id,
    required this.icon,
    required this.title,
    required this.time,
    this.done = false,
  });
}

// 수면 기록 모델
class SleepRecord {
  final DateTime date;
  final TimeOfDay sleepTime;
  final TimeOfDay wakeUpTime;
  final String duration; // 예: "X시간 Y분"
  final String quality; // 예: "개운함 😊"
  final String? diary;

  SleepRecord({
    required this.date,
    required this.sleepTime,
    required this.wakeUpTime,
    required this.duration,
    required this.quality,
    this.diary,
  });
}

// --- 앱 상태 관리 클래스 (ChangeNotifier) ---

// 앱의 전반적인 상태를 관리합니다.
// 실제 프로젝트에서는 'package:flutter/foundation.dart'의 ChangeNotifier를 상속받습니다.
class AppState extends ChangeNotifier {
  // ChangeNotifier를 상속받아야 함
  // --- 상태 데이터 ---
  UserData _userData = UserData(
    // 초기 더미 데이터
    name: "꿀잠 메이트",
    statusMessage: "오늘도 꿀잠 자요! 😴",
    wakeUpGoal: "07:00 AM",
    sleepGoal: "11:30 PM",
  );
  final double _sleepGoalProgress = Random().nextDouble(); // 예시 진행률
  final List<Routine> _routines = _generateInitialRoutines(); // 루틴 목록
  final List<SleepRecord> _sleepRecords =
      _generateInitialSleepRecords(); // 수면 기록 목록
  final String _currentTipTitle = "규칙적인 취침 시간 ⏰";
  final String _currentTipContent =
      "매일 같은 시간에 잠자리에 들고 일어나는 것은 생체 리듬을 안정시켜 수면의 질을 높이는 가장 기본적인 방법입니다.";

  // --- Getter 메서드 (UI에서 상태 데이터 접근용) ---
  UserData get userData => _userData;
  double get sleepGoalProgress => _sleepGoalProgress;
  List<Routine> get routines => _routines;
  List<SleepRecord> get sleepRecords => _sleepRecords;
  String get currentTipTitle => _currentTipTitle;
  String get currentTipContent => _currentTipContent;

  // --- 상태 변경 메서드 ---

  // 루틴 완료 상태 토글
  void toggleRoutineDone(int id) {
    final index = _routines.indexWhere((routine) => routine.id == id);
    if (index != -1) {
      _routines[index].done = !_routines[index].done;
      notifyListeners(); // 상태 변경 알림 (UI 업데이트 트리거)
    }
  }

  // 사용자 정보 업데이트 (예시)
  void updateUserName(String newName) {
    _userData = UserData(
      name: newName,
      statusMessage: _userData.statusMessage,
      wakeUpGoal: _userData.wakeUpGoal,
      sleepGoal: _userData.sleepGoal,
      profileImageUrl: _userData.profileImageUrl,
    );
    notifyListeners();
  }

  // TODO: 다른 상태 변경 메서드 추가 (수면 기록 추가, 팁 업데이트 등)

  // --- Helper: 초기 더미 데이터 생성 ---
  static List<Routine> _generateInitialRoutines() {
    return [
      Routine(
        id: 1,
        icon: Icons.directions_walk,
        title: '저녁 산책',
        time: '오후 7:00',
        done: false,
      ),
      Routine(
        id: 2,
        icon: Icons.no_food_outlined,
        title: '카페인 섭취 제한',
        time: '오후 7:00 부터',
        done: false,
      ),
      Routine(
        id: 3,
        icon: Icons.phone_android_outlined,
        title: '스마트폰 사용 중단',
        time: '오후 10:00',
        done: false,
      ),
      Routine(
        id: 4,
        icon: Icons.bathtub_outlined,
        title: '따뜻한 샤워',
        time: '오후 10:15',
        done: false,
      ),
      Routine(
        id: 5,
        icon: Icons.book_outlined,
        title: '독서 또는 명상',
        time: '오후 10:45',
        done: false,
      ),
    ];
  }

  static List<SleepRecord> _generateInitialSleepRecords() {
    return List.generate(10, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      final sleepDuration = Duration(
        hours: 7 + Random().nextInt(2),
        minutes: Random().nextInt(60),
      );
      return SleepRecord(
        date: date,
        sleepTime: TimeOfDay(
          hour: 22 + Random().nextInt(2),
          minute: Random().nextInt(60),
        ),
        wakeUpTime: TimeOfDay.fromDateTime(date.add(sleepDuration)),
        duration:
            "${sleepDuration.inHours}시간 ${sleepDuration.inMinutes.remainder(60)}분",
        quality: ['개운함 😊', '보통 🙂', '피곤함 😴'][Random().nextInt(3)],
        diary: index % 3 == 0 ? '오늘은 꿈을 많이 꾼 것 같다.' : null,
      );
    });
  }
}

// --- 색상, 폰트, 테마 정의 (이전과 동일) ---
// ... (이전 코드의 색상, 폰트, 테마 정의 부분 복사) ...
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
final String? fontFamilyTitle = GoogleFonts.montserrat().fontFamily;
final String? fontFamilyBody = GoogleFonts.lato().fontFamily;
final String? fontFamilyButton = GoogleFonts.openSans().fontFamily;
ThemeData lightTheme = ThemeData(
  /* ... 이전 테마 정의 ... */
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColorLight,
  cardColor: surfaceColorLight,
  hintColor: secondaryColor,
  dividerColor: Colors.grey.shade300,
  textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme).copyWith(
    headlineSmall: TextStyle(
      fontFamily: fontFamilyTitle,
      color: textColorPrimaryLight,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamilyTitle,
      color: textColorPrimaryLight,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamilyTitle,
      color: textColorPrimaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamilyBody,
      color: textColorPrimaryLight,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamilyBody,
      color: textColorSecondaryLight,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamilyBody,
      color: textColorSecondaryLight,
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamilyButton,
      color: surfaceColorLight,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColorLight,
    foregroundColor: textColorPrimaryLight,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: fontFamilyTitle,
      color: textColorPrimaryLight,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
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
      textStyle: TextStyle(
        fontFamily: fontFamilyButton,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
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

// --- 앱 진입점 (Provider 설정 추가 - 주석 처리) ---
void main() {
  // 실제 프로젝트에서는 여기서 Provider를 설정합니다.
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => AppState(), // AppState 인스턴스 생성 및 제공
  //     child: const SleepHealthApp(),
  //   ),
  // );
  runApp(const SleepHealthApp()); // DartPad에서는 Provider 없이 실행
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

// --- 메인 화면 (하단 탭 네비게이션 포함 - 상태 접근 구조로 변경) ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 각 탭 화면 위젯 리스트 (const 제거)
  // 각 화면은 이제 Provider를 통해 AppState에 접근할 수 있습니다.
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const RecordsScreen(),
    const StatsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 실제 프로젝트에서는 여기서 Provider.of<AppState>(context) 등으로 AppState에 접근 가능
    // 예: final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        // ... (이전 BottomNavigationBar 설정과 동일) ...
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_outlined),
            activeIcon: Icon(Icons.notes),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton:
          _selectedIndex == 0 || _selectedIndex == 1
              ? FloatingActionButton(
                onPressed: () {
                  String message = _selectedIndex == 0 ? '빠른 기록' : '새 기록 작성';
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('$message 기능 구현 예정')));
                },
                tooltip: _selectedIndex == 0 ? '빠른 기록' : '새 기록 작성',
                child: const Icon(Icons.add),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// --- 홈 화면 (StatelessWidget으로 변경, Provider 사용 구조) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();

    // --- Provider 사용 예시 (주석 처리) ---
    // 실제 프로젝트:
    // final appState = context.watch<AppState>(); // 상태 읽기 및 변경 감지
    // final userData = appState.userData;
    // final routines = appState.routines;
    // final sleepGoalProgress = appState.sleepGoalProgress;
    // final tipTitle = appState.currentTipTitle;
    // final tipContent = appState.currentTipContent;

    // DartPad용 임시 데이터 접근 (AppState 인스턴스 직접 생성 - 실제 앱에서는 이렇게 하지 않음!)
    final appState = AppState();
    final userData = appState.userData;
    final routines = appState.routines;
    final sleepGoalProgress = appState.sleepGoalProgress;
    final tipTitle = appState.currentTipTitle;
    final tipContent = appState.currentTipContent;
    // ------------------------------------

    final greeting = _getGreeting(now.hour, userData.name);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(greeting, style: theme.textTheme.headlineSmall),
            ),
            // 상태 데이터를 사용하는 위젯 빌더 호출
            _buildSleepGoalCardDetailed(
              context,
              sleepGoalProgress,
              userData.wakeUpGoal,
              userData.sleepGoal,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "오늘의 수면 루틴 🗓️", () {
              /* ... */
            }),
            const SizedBox(height: 16),
            // 상태 데이터를 사용하는 위젯 빌더 호출
            _buildRoutineListDetailed(context, routines, (id) {
              // --- Provider 사용 예시 (주석 처리) ---
              // 실제 프로젝트:
              // context.read<AppState>().toggleRoutineDone(id); // 상태 변경 메서드 호출
              print('Toggle routine $id (Provider)'); // DartPad에서는 호출 불가
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('루틴 완료 상태 변경 기능 구현 예정 (Provider)')),
              );
              // ------------------------------------
            }),
            const SizedBox(height: 24),
            // 상태 데이터를 사용하는 위젯 빌더 호출
            _buildSleepTipCardDetailed(context, tipTitle, tipContent),
            const SizedBox(height: 24),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // 시간대별 인사말 반환 함수 (동일)
  String _getGreeting(int hour, String name) {
    /* ... */
    if (hour < 5) return "$name님, 편안한 밤 보내세요 🌃";
    if (hour < 12) return "$name님, 좋은 아침! ☀️";
    if (hour < 18) return "$name님, 오후도 활기차게! 😊";
    return "$name님, 편안한 저녁 시간 되세요 🌙";
  }

  // 섹션 타이틀 위젯 빌더 (동일)
  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    VoidCallback onViewAll,
  ) {
    /* ... */
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        TextButton(onPressed: onViewAll, child: const Text('전체 보기')),
      ],
    );
  }

  // 상세 UI 구현 함수들 (이전과 동일, 상태 데이터 받도록 유지)
  Widget _buildSleepGoalCardDetailed(
    BuildContext context,
    double progress,
    String wakeUpGoal,
    String sleepGoal,
  ) {
    /* ... 이전과 동일 ... */
    final theme = Theme.of(context);
    final String progressText = "${(progress * 100).toInt()}%";
    return Card(
      color: primaryColor,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘의 수면 목표',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: surfaceColorLight.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: surfaceColorLight.withOpacity(0.9),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '기상: $wakeUpGoal',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: surfaceColorLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.bedtime_outlined,
                          color: surfaceColorLight.withOpacity(0.9),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '취침: $sleepGoal',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: surfaceColorLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: surfaceColorLight.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        surfaceColorLight,
                      ),
                    ),
                    Text(
                      progressText,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: surfaceColorLight,
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

  Widget _buildRoutineListDetailed(
    BuildContext context,
    List<Routine> routines,
    Function(int) onToggleDone,
  ) {
    /* ... */
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return _buildRoutineItemDetailed(
            context,
            routine.icon,
            routine.title,
            routine.time,
            routine.done,
            () => onToggleDone(routine.id),
          );
        },
      ),
    );
  }

  Widget _buildRoutineItemDetailed(
    BuildContext context,
    IconData icon,
    String title,
    String time,
    bool isDone,
    VoidCallback onTap,
  ) {
    /* ... */
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(right: 12),
      elevation: isDone ? 0.5 : 1.5,
      color: isDone ? surfaceColorLight.withOpacity(0.7) : surfaceColorLight,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: isDone ? textColorSecondaryLight : primaryColor,
                    size: 30,
                  ),
                  Icon(
                    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color:
                        isDone
                            ? successColor
                            : textColorSecondaryLight.withOpacity(0.5),
                    size: 22,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      isDone ? textColorSecondaryLight : textColorPrimaryLight,
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                time,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColorSecondaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSleepTipCardDetailed(
    BuildContext context,
    String title,
    String content,
  ) {
    /* ... */
    final theme = Theme.of(context);
    return Card(
      color: surfaceColorLight,
      elevation: 1.5,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  color: textColorPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColorPrimaryLight,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('더 알아보기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 기록 화면 (Provider 사용 구조) ---
class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  // 날짜/시간 포맷 함수 (동일)
  String _formatDate(DateTime date) {
    const List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return "${date.month}월 ${date.day}일 (${weekdays[date.weekday - 1]})";
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? '오전' : '오후';
    return "$period $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- Provider 사용 예시 (주석 처리) ---
    // 실제 프로젝트:
    // final appState = context.watch<AppState>();
    // final sleepRecords = appState.sleepRecords;

    // DartPad용 임시 데이터 접근
    final appState = AppState();
    final sleepRecords = appState.sleepRecords;
    // ------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 수면 기록'),
        actions: [
          /* ... 이전 actions 동일 ... */ IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            tooltip: '날짜 선택',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('캘린더 날짜 선택 기능 구현 예정')),
              );
            },
          ),
        ],
      ),
      body:
          sleepRecords.isEmpty
              ? Center(
                // 기록 없을 때 Empty State
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.nights_stay_outlined,
                      size: 64,
                      color: textColorSecondaryLight,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '아직 기록된 수면 데이터가 없습니다.',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '오늘 밤부터 기록을 시작해보세요!',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
              : ListView.builder(
                // 기록 있을 때 목록 표시
                padding: const EdgeInsets.all(8.0),
                itemCount: sleepRecords.length,
                itemBuilder: (context, index) {
                  final record = sleepRecords[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6.0,
                    ),
                    child: ListTile(
                      /* ... 이전 ListTile 구조와 유사 ... */
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            record.date.day.toString(),
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            '${record.date.month}월 (${['월', '화', '수', '목', '금', '토', '일'][record.date.weekday - 1]})',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      title: Text(
                        '${_formatTime(record.sleepTime)} - ${_formatTime(record.wakeUpTime)} (${record.duration})',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            '수면 만족도: ${record.quality}',
                            style: theme.textTheme.bodyMedium,
                          ),
                          if (record.diary != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '일기: ${record.diary}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: textColorSecondaryLight,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${_formatDate(record.date)} 상세 기록 보기 구현 예정',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* ... */
        },
        tooltip: '새 수면 기록',
        child: const Icon(Icons.edit_note),
      ),
    );
  }
}

// --- 통계 화면 (StatelessWidget, Provider 사용 구조) ---
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  // 더미 통계 데이터 (추후 Provider에서 가져옴)
  final String avgSleepDuration = "7시간 15분";
  final double weeklyGoalRate = 0.78;
  final String avgSleepQuality = "보통 🙂";
  final String consistencyScore = "65점";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- Provider 사용 예시 (주석 처리) ---
    // 실제 프로젝트:
    // final appState = context.watch<AppState>();
    // final avgSleepDuration = appState.calculatedAvgSleepDuration; // 예시
    // final weeklyGoalRate = appState.calculatedWeeklyGoalRate; // 예시
    // ... 등등
    // ------------------------------------

    return Scaffold(
      appBar: AppBar(
        /* ... 이전 AppBar 설정과 동일 ... */
        title: const Text('수면 통계'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: '기간 선택',
            onSelected: (String result) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$result 통계 보기 구현 예정')));
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: '주간',
                    child: Text('주간 통계'),
                  ),
                  const PopupMenuItem<String>(
                    value: '월간',
                    child: Text('월간 통계'),
                  ),
                  const PopupMenuItem<String>(
                    value: '연간',
                    child: Text('연간 통계'),
                  ),
                ],
          ),
        ],
      ),
      body: ListView(
        /* ... 이전 ListView 구조와 유사 ... */
        padding: const EdgeInsets.all(16.0),
        children: [
          Text("최근 7일 데이터 요약", style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            children: [
              _buildStatCard(
                context,
                Icons.hourglass_bottom_outlined,
                '평균 수면 시간',
                avgSleepDuration,
              ),
              _buildStatCard(
                context,
                Icons.check_circle_outline,
                '주간 목표 달성률',
                "${(weeklyGoalRate * 100).toInt()}%",
                highlightColor: successColor,
              ),
              _buildStatCard(
                context,
                Icons.sentiment_satisfied_alt_outlined,
                '평균 수면 만족도',
                avgSleepQuality,
              ),
              _buildStatCard(
                context,
                Icons.schedule_outlined,
                '수면 규칙성 점수',
                consistencyScore,
                highlightColor: secondaryColor,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text("수면 시간 추이 (그래프 구현 예정)", style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: surfaceColorLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Center(
              child: Text(
                "주간/월간 수면 시간 그래프 영역",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text("수면 만족도 분포 (그래프 구현 예정)", style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: surfaceColorLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Center(
              child: Text(
                "수면 만족도 비율 원형/막대 그래프 영역",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 통계 카드 위젯 빌더 (동일)
  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String title,
    String value, {
    Color? highlightColor,
  }) {
    /* ... 이전과 동일 ... */
    final theme = Theme.of(context);
    final color = highlightColor ?? primaryColor;
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 32, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- 설정 화면 (StatelessWidget으로 변경, Provider 사용 구조) ---
class SettingsScreen extends StatelessWidget {
  // StatelessWidget으로 변경
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- Provider 사용 예시 (주석 처리) ---
    // 실제 프로젝트:
    // final appState = context.watch<AppState>();
    // final userData = appState.userData;
    // final weeklyGoalAchievedRate = appState.calculatedWeeklyGoalRate; // 예시

    // DartPad용 임시 데이터 접근
    final appState = AppState();
    final userData = appState.userData;
    final weeklyGoalAchievedRate = 0.85; // 임시 데이터
    // ------------------------------------

    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            /* ... 이전 AppBar 설정과 유사, 상태 데이터 사용 ... */
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: primaryColor,
            elevation: 0,
            foregroundColor: surfaceColorLight,
            iconTheme: const IconThemeData(color: surfaceColorLight),
            actionsIconTheme: const IconThemeData(color: surfaceColorLight),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                userData.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: textColorPrimaryLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titlePadding: const EdgeInsetsDirectional.only(
                start: 72,
                bottom: 16,
              ),
              background: Container(
                /* ... 이전 배경 설정과 유사, 상태 데이터 사용 ... */
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withOpacity(0.8), primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: surfaceColorLight.withOpacity(0.9),
                        child:
                            userData.profileImageUrl.isEmpty
                                ? Text(
                                  userData.name.isNotEmpty
                                      ? userData.name[0].toUpperCase()
                                      : '?',
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(color: primaryColor),
                                )
                                : ClipOval(
                                  child: Image.network(
                                    'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userData.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: surfaceColorLight,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        userData.statusMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: surfaceColorLight.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              /* ... 이전 actions 설정과 동일 ... */ IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: '프로필 수정',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('프로필 수정 화면 구현 예정')),
                  );
                },
              ),
            ],
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),

          // 설정 메뉴 리스트
          SliverPadding(
            /* ... 이전 Padding 설정과 동일 ... */
            padding: const EdgeInsets.only(top: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 상태 데이터 사용
                _buildInfoCard(
                  context,
                  '수면 목표',
                  '기상 ${userData.wakeUpGoal} / 취침 ${userData.sleepGoal}',
                  Icons.flag_outlined,
                  () {
                    /* ... */
                  },
                ),
                _buildInfoCard(
                  context,
                  '주간 달성률',
                  '${(weeklyGoalAchievedRate * 100).toInt()}%',
                  Icons.check_circle_outline,
                  () {
                    /* ... */
                  },
                  highlightColor: successColor,
                ),
                const SizedBox(height: 8),
                const Divider(),
                _buildSettingsListTile(
                  context,
                  Icons.analytics_outlined,
                  '수면 통계 및 분석',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(
                  context,
                  Icons.note_alt_outlined,
                  '나의 수면 일기 모아보기',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(
                  context,
                  Icons.bookmark_border_outlined,
                  '나중에 보기',
                  () {
                    /* ... */
                  },
                ),
                const Divider(),
                _buildSettingsListTile(
                  context,
                  Icons.notifications_outlined,
                  '알림 설정',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(
                  context,
                  Icons.settings_outlined,
                  '앱 환경 설정',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(
                  context,
                  Icons.shield_outlined,
                  '계정 및 개인정보',
                  () {
                    /* ... */
                  },
                ),
                const Divider(),
                _buildSettingsListTile(
                  context,
                  Icons.star_border_outlined,
                  '프리미엄 기능',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(
                  context,
                  Icons.help_outline,
                  '도움말 및 고객지원',
                  () {
                    /* ... */
                  },
                ),
                _buildSettingsListTile(context, Icons.info_outline, '앱 정보', () {
                  /* ... */
                }),
                _buildSettingsListTile(context, Icons.logout, '로그아웃', () {
                  /* ... */
                }, color: accentColor),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // 설정 화면 상단 정보 카드 위젯 빌더 (동일)
  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    VoidCallback onTap, {
    Color? highlightColor,
  }) {
    /* ... 이전과 동일 ... */
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: highlightColor ?? primaryColor),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: highlightColor ?? textColorPrimaryLight,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: textColorSecondaryLight,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  // 설정 메뉴 리스트 타일 위젯 빌더 (동일)
  Widget _buildSettingsListTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    /* ... 이전과 동일 ... */
    final theme = Theme.of(context);
    final tileColor = color ?? theme.listTileTheme.iconColor;
    return ListTile(
      leading: Icon(icon, color: tileColor),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: textColorPrimaryLight,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: textColorSecondaryLight),
      onTap: onTap,
    );
  }
}

// --- ChangeNotifier 정의 (실제 프로젝트에서는 별도 파일 분리) ---
// foundation.dart import 없이 기본적인 동작만 흉내냅니다.
class ChangeNotifier {
  List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    // 실제로는 리스너 호출 로직 필요
    print("AppState: notifyListeners() called");
  }

  void dispose() {
    _listeners = [];
  }
}
