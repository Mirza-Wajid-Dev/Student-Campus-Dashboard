import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const CampusApp());
}

// ============================================================
// APP
// ============================================================

class CampusApp extends StatelessWidget {
  const CampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Connect',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ============================================================
// DASHBOARD SCREEN
// ============================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _pageController;
  late AnimationController _pulseController;

  final TextEditingController noteController = TextEditingController();

  String note = '';

  final List<Course> courses = [
    Course(
      name: 'Mobile Application Development',
      code: 'CSC303',
      icon: Icons.phone_android_rounded,
      color: const Color(0xFF6366F1),
    ),
    Course(
      name: 'Operating Systems',
      code: 'CSC323',
      icon: Icons.account_tree_rounded,
      color: const Color(0xFF06B6D4),
    ),
    Course(
      name: 'Web Technologies',
      code: 'CSC336',
      icon: Icons.language_rounded,
      color: const Color(0xFFEC4899),
    ),
    Course(
      name: 'Software Design & Architecture',
      code: 'CSC305',
      icon: Icons.code_rounded,
      color: const Color(0xFF8B5CF6),
    ),
    Course(
      name: 'Comuter Organization and Assembly Language',
      code: 'CSC325',
      icon: Icons.storage_rounded,
      color: const Color(0xFF10B981),
    ),
    Course(
      name: 'Multivariable Calculus',
      code: 'MTH105',
      icon: Icons.wifi_rounded,
      color: const Color(0xFFF59E0B),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pulseController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void addNote() {
    if (noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a note first.'),
        ),
      );
      return;
    }

    setState(() {
      note = noteController.text.trim();
      noteController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Note added successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 98, 33, 176),
        foregroundColor: Colors.white,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Campus Connect',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            Text(
              'Student Dashboard',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CourseSearchDelegate(courses),
              );
            },
          ),

          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                ),
              );
            },
          ),

          const SizedBox(width: 6),
        ],
      ),

      // ========================================================
      // DRAWER
      // ========================================================

      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5B5FEF),
                Color(0xFF312E81),
                Color(0xFF111827),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [

                // Profile Header
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 43,
                              backgroundColor: Color(0xFFE0E7FF),
                              child: Icon(
                                Icons.person_rounded,
                                size: 55,
                                color: Color(0xFF5B5FEF),
                              ),
                            ),
                          ),

                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Container(
                                width: 20 + _pulseController.value * 3,
                                height: 20 + _pulseController.value * 3,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        'Mirza Wajid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'BS Software Engineering',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.white24,
                  indent: 20,
                  endIndent: 20,
                ),

                const SizedBox(height: 10),

                DrawerItem(
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                DrawerItem(
                  icon: Icons.badge_rounded,
                  title: 'Digital ID Card',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                DrawerItem(
                  icon: Icons.person_rounded,
                  title: 'Student Profile',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                DrawerItem(
                  icon: Icons.menu_book_rounded,
                  title: 'My Courses',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                DrawerItem(
                  icon: Icons.settings_rounded,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                const Spacer(),

                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'CSC303 • Mobile Application Development',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ------------------------------------------------
              // WELCOME
              // ------------------------------------------------

              FadeTransition(
                opacity: CurvedAnimation(
                  parent: _pageController,
                  curve: Curves.easeOut,
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.3),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _pageController,
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Wajid 👋',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Manage your campus life from one place.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ------------------------------------------------
              // DIGITAL ID CARD
              // ------------------------------------------------

              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.92,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _pageController,
                    curve: Curves.easeOutBack,
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6366F1),
                        Color(0xFF4F46E5),
                        Color(0xFF312E81),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5)
                            .withOpacity(0.30),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [

                      // Decorative circles
                      Positioned(
                        right: -45,
                        top: -45,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Positioned(
                        left: -55,
                        bottom: -70,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [

                            Row(
                              children: [
                                const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'DIGITAL STUDENT ID',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontSize: 13,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'ACTIVE',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            // Profile
                            Stack(
                              clipBehavior: Clip.none,
                              children: [

                                const CircleAvatar(
                                  radius: 52,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 47,
                                    backgroundColor: Color(0xFFE0E7FF),
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 62,
                                      color: Color(0xFF4F46E5),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  right: 0,
                                  bottom: 2,
                                  child: AnimatedBuilder(
                                    animation: _pulseController,
                                    builder: (context, child) {
                                      return Container(
                                        width: 22 +
                                            _pulseController.value * 4,
                                        height: 22 +
                                            _pulseController.value * 4,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              'Mirza Wajid',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              'BS Software Engineering',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Information
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: StudentInfo(
                                          icon: Icons.badge_rounded,
                                          title: 'ROLL NUMBER',
                                          value: 'FA24-BSE-086',
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: StudentInfo(
                                          icon: Icons.school_rounded,
                                          title: 'PROGRAM',
                                          value: 'BSSE',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  Row(
                                    children: const [
                                      Expanded(
                                        child: StudentInfo(
                                          icon: Icons.computer_rounded,
                                          title: 'DEPARTMENT',
                                          value: 'Software Eng.',
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: StudentInfo(
                                          icon: Icons.calendar_month_rounded,
                                          title: 'SEMESTER',
                                          value: '5th',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ------------------------------------------------
              // QUICK STATISTICS
              // ------------------------------------------------

              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.menu_book_rounded,
                      value: '06',
                      label: 'Courses',
                      color: Color(0xFF6366F1),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.check_circle_rounded,
                      value: '92%',
                      label: 'Attendance',
                      color: Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DashboardStat(
                      icon: Icons.star_rounded,
                      value: 'A',
                      label: 'Grade',
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ------------------------------------------------
              // COURSES
              // ------------------------------------------------

              Row(
                children: [
                  const Text(
                    'Current Courses',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E7FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${courses.length} Subjects',
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 13),

              // ListView.builder
              SizedBox(
                height: 390,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];

                    return TweenAnimationBuilder<double>(
                      duration: Duration(
                        milliseconds: 500 + (index * 100),
                      ),
                      tween: Tween(begin: 0, end: 1),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(
                              35 * (1 - value),
                              0,
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: CourseCard(
                        course: course,
                        index: index,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // QUICK NOTES
              // ------------------------------------------------

              const Text(
                'Quick Notes',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write something important...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 38),
                          child: Icon(
                            Icons.edit_note_rounded,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F7FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: addNote,
                        icon: const Icon(
                          Icons.add_rounded,
                        ),
                        label: const Text(
                          'Save Note',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF5B5FEF),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor:
                              const Color(0xFF5B5FEF)
                                  .withOpacity(0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),

                    if (note.isNotEmpty) ...[
                      const SizedBox(height: 14),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sticky_note_2_rounded,
                              color: Color(0xFF4F46E5),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                note,
                                style: const TextStyle(
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // FOOTER
              // ------------------------------------------------

              Center(
                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6366F1),
                            Color(0xFF8B5CF6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'COMSATS University',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF374151),
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'CSC303 • Mobile Application Development',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Digital Campus Experience',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
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

// ============================================================
// COURSE MODEL
// ============================================================

class Course {
  final String name;
  final String code;
  final IconData icon;
  final Color color;

  Course({
    required this.name,
    required this.code,
    required this.icon,
    required this.color,
  });
}

// ============================================================
// STUDENT INFO
// ============================================================

class StudentInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StudentInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// DRAWER ITEM
// ============================================================

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        selected: selected,
        selectedTileColor: Colors.white.withOpacity(0.14),
        leading: Icon(
          icon,
          color: selected ? Colors.white : Colors.white70,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// STAT CARD
// ============================================================

class DashboardStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const DashboardStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COURSE CARD
// ============================================================

class CourseCard extends StatefulWidget {
  final Course course;
  final int index;

  const CourseCard({
    super.key,
    required this.course,
    required this.index,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          pressed = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 900),
            content: Text(
              '${widget.course.name} selected',
            ),
          ),
        );
      },
      onTapCancel: () {
        setState(() {
          pressed = false;
        });
      },
      child: AnimatedScale(
        scale: pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 11),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [

              // Course icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.course.color,
                      widget.course.color.withOpacity(0.65),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.course.icon,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              const SizedBox(width: 13),

              // Course information
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: widget.course.color
                                .withOpacity(0.10),
                            borderRadius:
                                BorderRadius.circular(7),
                          ),
                          child: Text(
                            widget.course.code,
                            style: TextStyle(
                              color: widget.course.color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 7),

                        const Text(
                          'Current Semester',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SEARCH
// ============================================================

class CourseSearchDelegate extends SearchDelegate<String> {
  final List<Course> courses;

  CourseSearchDelegate(this.courses);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  List<Course> get results {
    return courses
        .where(
          (course) =>
              course.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
              course.code.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: course.color,
            child: Icon(
              course.icon,
              color: Colors.white,
            ),
          ),
          title: Text(course.name),
          subtitle: Text(course.code),
          onTap: () {
            close(context, course.name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];

        return ListTile(
          leading: Icon(
            course.icon,
            color: course.color,
          ),
          title: Text(course.name),
          subtitle: Text(course.code),
          onTap: () {
            query = course.name;
            showResults(context);
          },
        );
      },
    );
  }
}