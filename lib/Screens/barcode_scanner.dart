import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../ScreensGuest/Scan_product_screen_guest.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>with WidgetsBindingObserver {
  Barcode? _barcode;
  bool hasNavigated = false;
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    try {
      await controller.start();
    } catch (e) {
      debugPrint('Failed to start camera: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        controller.stop();
        break;
      default:
        break;
    }
  }

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void handleBarcode(BarcodeCapture barcodes) {
    if (!mounted || hasNavigated) return;

    final capturedBarcode = barcodes.barcodes.firstOrNull;
    if (capturedBarcode == null) return;

    setState(() {
      _barcode = capturedBarcode;
      hasNavigated = true;
    });

    final barcodeValue = capturedBarcode.displayValue;
    if (barcodeValue != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanProductScreenGuest(
            nome: barcodeValue,
            immagine: "https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato.png",
          ),
        ),
      ).then((_) {
        if (mounted) {
          setState(() {
            hasNavigated = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: handleBarcode,
            scanWindow: Rect.fromCenter(
                center: Offset(MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,), width: 300, height: 300),
          ),
          CustomPaint(
            painter: ScannerOverlay(),
            child: const SizedBox.expand(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final windowSize = 300.0;
    final left = (size.width - windowSize) / 2;
    final top = (size.height - windowSize) / 2;

    // Disegna l'overlay scuro
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(left, top, windowSize, windowSize),
              const Radius.circular(12),
            ),
          ),
      ),
      paint,
    );


    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, windowSize, windowSize),
        const Radius.circular(12),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
