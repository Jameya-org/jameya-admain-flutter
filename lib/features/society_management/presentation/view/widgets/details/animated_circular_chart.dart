import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedCircularChartWidget extends StatefulWidget {
  final double progress;
  final String collectedAmount;
  final String targetAmount;
  final String currentTurn;
  final String totalTurns;

  const AnimatedCircularChartWidget({
    super.key,
    this.progress = 0.75,
    this.collectedAmount = '12,000 /9,000',
    this.targetAmount = 'مبلغ تحصيل الشهر',
    this.currentTurn = '4',
    this.totalTurns = '12',
  });

  @override
  State<AnimatedCircularChartWidget> createState() => _AnimatedCircularChartWidgetState();
}

class _AnimatedCircularChartWidgetState extends State<AnimatedCircularChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: _animation.value, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double chartSize = 220.w;
    final double radius = (chartSize - 24.w) / 2;

    return SizedBox(
      width: chartSize,
      height: chartSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Gauge Arcs (rendered underneath the image edges)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(chartSize, chartSize),
                painter: _CircularGaugePainter(
                  progress: _animation.value,
                  radius: radius,
                ),
              );
            },
          ),
          // Texture circle image rendered ON TOP of gauge arcs so rough edges overlap
          Image.asset(
            'assets/images/circle_chart.png',
            width: 205.w,
            height: 205.h,
            fit: BoxFit.contain,
          ),
          // Center Text Overlay
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.targetAmount,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFFF59E0B),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                widget.collectedAmount,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF59E0B),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'الأنجاز',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF00796B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${widget.totalTurns} / ${widget.currentTurn}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00796B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final double progress;
  final double radius;

  _CircularGaugePainter({required this.progress, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 14.0;

    // Background track arc (Teal)
    final bgPaint = Paint()
      ..color = const Color(0xFF00796B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Foreground progress arc (Gold/Amber)
    final fgPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = 135 * (math.pi / 180);
    const totalSweep = 270 * (math.pi / 180);

    // Draw background track
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweep,
      false,
      bgPaint,
    );

    // Draw progress arc
    final currentSweep = totalSweep * progress.clamp(0.0, 1.0);
    if (currentSweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        currentSweep,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.radius != radius;
}
