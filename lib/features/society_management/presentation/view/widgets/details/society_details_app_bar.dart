import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../dialogs/end_society_dialog.dart';
import '../dialogs/pause_society_dialog.dart';
import '../dialogs/delete_society_dialog.dart';

class SocietyDetailsAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  const SocietyDetailsAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  State<SocietyDetailsAppBar> createState() => _SocietyDetailsAppBarState();
}

class _SocietyDetailsAppBarState extends State<SocietyDetailsAppBar>
    with SingleTickerProviderStateMixin {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _removeOverlay(immediate: true);
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    final double screenWidth = MediaQuery.of(context).size.width;

    const double menuWidth = 180;
    double leftPosition = offset.dx + size.width - menuWidth.w;
    leftPosition = leftPosition.clamp(20.w, screenWidth - menuWidth.w - 8.w);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              top: offset.dy + size.height + 4.h,
              left: leftPosition,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildMenuCard(),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward(from: 0);
  }

  void _closeMenu() {
    _controller.reverse().whenComplete(() {
      _removeOverlay();
    });
  }

  void _removeOverlay({bool immediate = false}) {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onMenuSelected(String value) {
    _closeMenu();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      if (value == 'end') {
        showDialog(context: context, builder: (_) => const EndSocietyDialog());
      } else if (value == 'pause') {
        showDialog(
          context: context,
          builder: (_) => const PauseSocietyDialog(),
        );
      } else if (value == 'delete') {
        showDialog(
          context: context,
          builder: (_) => const DeleteSocietyDialog(),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('تم اختيار: $value')));
      }
    });
  }

  Widget _buildMenuCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 180.w,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem('تعديل الجمعية', 'edit'),
            _menuItem('تفعيل الجمعية', 'activate'),
            _menuItem('إنهاء الجمعية', 'end'),
            _menuItem('إيقاف الجمعية مؤقتا', 'pause'),
            _menuItem('حذف الجمعية', 'delete', isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(String label, String value, {bool isDestructive = false}) {
    return InkWell(
      onTap: () => _onMenuSelected(value),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: isDestructive ? Colors.red : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: const Color(0xFF00796B),
          size: 18.sp,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        widget.title.isNotEmpty ? widget.title : 'جمعية شهر 12',
        style: TextStyle(
          color: const Color(0xFF00796B),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          key: _menuKey,
          onPressed: _toggleMenu,
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 22.sp,
            height: 22.sp,
            colorFilter: const ColorFilter.mode(
              Color(0xFF00796B),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
