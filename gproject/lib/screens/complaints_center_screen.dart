import 'package:flutter/material.dart';

class ComplaintsCenterScreen extends StatefulWidget {
  const ComplaintsCenterScreen({super.key});

  @override
  State<ComplaintsCenterScreen> createState() => _ComplaintsCenterScreenState();
}

class _ComplaintsCenterScreenState extends State<ComplaintsCenterScreen> {
  String _selectedFilter = 'الكل';

  // بحث
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchText = '';

  final List<Map<String, dynamic>> _complaints = [
    {
      'title': 'بلاغ انقطاع الكهرباء',
      'meta': 'المعرف: #١٢٣٤٥٦ • وزارة الكهرباء',
      'date': 'تاريخ التقديم: ٢٢ مايو ٢٠٢٤',
      'status': 'قيد المراجعة',
    },
    {
      'title': 'حفرة في الشارع الرئيسي',
      'meta': 'المعرف: #١٢٣٤٥٥ • وزارة الأشغال',
      'date': 'تاريخ التقديم: ٢٠ مايو ٢٠٢٤',
      'status': 'تم حلها',
    },
    {
      'title': 'عطل في إنارة الشارع',
      'meta': 'المعرف: #١٢٣٤٥٤ • أمانة بغداد',
      'date': 'تاريخ التقديم: ١٨ مايو ٢٠٢٤',
      'status': 'مرفوضة',
    },
    {
      'title': 'تسرب في أنبوب مياه',
      'meta': 'المعرف: #١٢٣٤٥٧ • وزارة الموارد المائية',
      'date': 'تاريخ التقديم: ٢٣ مايو ٢٠٢٤',
      'status': 'مقدمة',
    },
  ];

  List<Map<String, dynamic>> get _filteredComplaints {
    // فلتر الحالة
    Iterable<Map<String, dynamic>> list = _complaints;
    if (_selectedFilter != 'الكل') {
      list = list.where((c) => c['status'] == _selectedFilter);
    }

    // فلتر البحث (على العنوان حاليًا)
    if (_searchText.isNotEmpty) {
      final q = _searchText.trim();
      list = list.where(
        (c) => c['title'].toString().contains(q),
      );
    }

    return list.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF137FEC);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // AppBar مخصص
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    color: const Color(0xFFF6F7F8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Color(0xFF1E293B), // slate-800
                          ),
                        ),

                        // عنوان أو صندوق بحث
                        Expanded(
                          child: _isSearching
                              ? Container(
                                  height: 40,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: const Color(0xFFCBD5E1),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: TextField(
                                    controller: _searchController,
                                    autofocus: true,
                                    textInputAction: TextInputAction.search,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'ابحث عن شكوى',
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _searchText = value;
                                      });
                                    },
                                  ),
                                )
                              : const Text(
                                  'مركز تتبع الشكاوى',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A), // slate-900
                                  ),
                                ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_isSearching) {
                                _isSearching = false;
                                _searchController.clear();
                                _searchText = '';
                              } else {
                                _isSearching = true;
                              }
                            });
                          },
                          icon: Icon(
                            _isSearching ? Icons.close : Icons.search,
                            size: 24,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // تبويبات شكاويي / الإشعارات
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 12),
                              Text(
                                'شكاويي',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 6),
                              SizedBox(
                                height: 3,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'الإشعارات',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF64748B), // slate-500
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // نقطة حمراء صغيرة بدون رقم
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 9),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // فلاتر الحالة (أفقية)
                  SizedBox(
                    height: 44,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterChip('الكل', primaryColor),
                        _buildFilterChip('قيد المراجعة', primaryColor),
                        _buildFilterChip('تم حلها', primaryColor),
                        _buildFilterChip('مرفوضة', primaryColor),
                        _buildFilterChip('مقدمة', primaryColor),
                      ],
                    ),
                  ),

                  // قائمة الشكاوى
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: _filteredComplaints.length,
                      itemBuilder: (context, index) {
                        final c = _filteredComplaints[index];
                        return _ComplaintCard(
                          title: c['title'],
                          meta: c['meta'],
                          date: c['date'],
                          status: c['status'],
                        );
                      },
                    ),
                  ),
                ],
              ),

              // زر إضافة شكوى جديد (أسفل يسار تقريباً)
              Positioned(
                bottom: 24,
                left: 24,
                child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/education-complaint', // تأكد من الاسم نفسه في routes
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color primaryColor) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              // ignore: deprecated_member_use
              ? primaryColor.withOpacity(0.15)
              : const Color(0xFFE2E8F0), // slate-200
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? primaryColor
                : const Color(0xFF334155), // slate-700
          ),
        ),
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final String title;
  final String meta;
  final String date;
  final String status;

  const _ComplaintCard({
    required this.title,
    required this.meta,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorConfig = _statusStyle(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان + حالة الشكوى
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meta,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colorConfig['bg'] as Color,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colorConfig['dot'] as Color,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colorConfig['text'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Color> _statusStyle(String status) {
    switch (status) {
      case 'قيد المراجعة':
        return {
          'bg': const Color(0xFFFFEDD5), // orange-100
          'dot': const Color(0xFFF97316), // orange-500
          'text': const Color(0xFFF97316),
        };
      case 'تم حلها':
        return {
          'bg': const Color(0xFFD1FAE5), // green-100
          'dot': const Color(0xFF22C55E), // green-500
          'text': const Color(0xFF22C55E),
        };
      case 'مرفوضة':
        return {
          'bg': const Color(0xFFFEE2E2), // red-100
          'dot': const Color(0xFFEF4444), // red-500
          'text': const Color(0xFFEF4444),
        };
      default: // مُقدمة
        return {
          'bg': const Color(0xFFE5E7EB), // slate-200
          'dot': const Color(0xFF6B7280), // slate-500
          'text': const Color(0xFF6B7280),
        };
    }
  }
}
