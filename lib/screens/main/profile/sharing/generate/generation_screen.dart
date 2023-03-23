import 'package:danny/constants/colors.dart';
import 'package:danny/models/range.dart';
import 'package:danny/screens/main/profile/sharing/generate/components/tracker_generation.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'components/wellbeing_generation.dart';

class GenerationScreen extends StatefulWidget {
  const GenerationScreen({
    Key? key,
    required this.type,
    required this.range,
    required this.options,
  }) : super(key: key);

  final bool type;
  final Range range;
  final List<String> options;

  @override
  _GenerationScreenState createState() => _GenerationScreenState();
}

class _GenerationScreenState extends State<GenerationScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  PageController pageController = PageController();
  List<PageController> pageControllerChildren = [];
  var pdf = pw.Document();
  DateFormat dateFormat = DateFormat('MMM d.');

  @override
  void initState() {
    super.initState();
    for (final _ in widget.options) {
      pageControllerChildren.add(PageController());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  @override
  void dispose() {
    pageController.dispose();
    for (final p in pageControllerChildren) {
      p.dispose();
    }
    super.dispose();
  }

  Future<void> _start() async {
    for (var i = 0; i < widget.options.length; i++) {
      if (widget.options[i] == 'Well-Being') {
        await _printWellBeing();
      } else {
        pageController.jumpToPage(i);
        await _printTracker(widget.options[i], i);
      }
    }

    final userId = Provider.of<FirebaseAuthService>(context, listen: false)
        .currentUser!
        .uid;
    await Provider.of<FirebaseStorageService>(context, listen: false)
        .uploadPdf(userId, await pdf.save());
    Navigator.pop(context);
  }

  Future<void> _printWellBeing() async {
    setState(() => isOn0 = true);
    Uint8List? bytes;
    final images = <pw.MemoryImage>[];

    for (var i = 0; i < (widget.type ? 3 : 4); i++) {
      bytes = await screenshotController.capture(
        pixelRatio: 5,
        delay: const Duration(milliseconds: 1000),
      );
      if (bytes == null) continue;
      images.add(pw.MemoryImage(bytes));
      if (i < (widget.type ? 2 : 3)) {
        if (isOn0) setState(() => isOn0 = false);
        pageControllerChildren[0].jumpToPage(i + 1);
      }
    }
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          // ignore: use_named_constants
          margin: const pw.EdgeInsets.all(0),
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Quicksand-Regular.ttf'),
            ),
            bold: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Avenir-Heavy.ttf'),
            ),
          ),
          buildBackground: (context) {
            return pw.Container(
              height: PdfPageFormat.a4.height,
              width: PdfPageFormat.a4.width,
              color: PdfColor.fromHex('#3ABEFF'),
            );
          },
        ),
        build: (context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.SizedBox(height: 5 * PdfPageFormat.mm),
                pw.Text(
                  'Well-Being',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 40,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  '${dateFormat.format(widget.range.start)} - ${dateFormat.format(widget.range.end)}',
                  style: const pw.TextStyle(
                    fontSize: 25,
                    color: PdfColors.white,
                  ),
                ),
                pw.Image(images[0], width: PdfPageFormat.a4.width),
                pw.Expanded(
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Expanded(
                        child: pw.Image(
                          images[1],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Image(
                          images[2],
                        ),
                      ),
                    ],
                  ),
                ),
                if (images.length == 4)
                  pw.Expanded(
                    child: pw.Image(
                      images[3],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _printTracker(String tracker, int index) async {
    setState(() => isOn0 = true);
    Uint8List? bytes;
    final images = <pw.MemoryImage>[];

    for (var i = 0; i < (widget.type ? 2 : 3); i++) {
      bytes = await screenshotController.capture(
        pixelRatio: 5,
        delay: const Duration(milliseconds: 1000),
      );

      if (bytes == null) continue;
      images.add(pw.MemoryImage(bytes));
      if (i < (widget.type ? 1 : 2)) {
        if (isOn0) setState(() => isOn0 = false);
        pageControllerChildren[index].jumpToPage(i + 1);
      }
    }

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          // ignore: use_named_constants
          margin: const pw.EdgeInsets.all(0),
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Quicksand-Regular.ttf'),
            ),
            bold: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Avenir-Heavy.ttf'),
            ),
          ),
          buildBackground: (context) {
            return pw.Container(
              height: PdfPageFormat.a4.height,
              width: PdfPageFormat.a4.width,
              color: PdfColor.fromHex('#3ABEFF'),
            );
          },
        ),
        build: (context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.SizedBox(height: 5 * PdfPageFormat.mm),
                pw.Text(
                  tracker,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 40,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  '${dateFormat.format(widget.range.start)} - ${dateFormat.format(widget.range.end)}',
                  style: const pw.TextStyle(
                    fontSize: 25,
                    color: PdfColors.white,
                  ),
                ),
                pw.Image(images[0], width: PdfPageFormat.a4.width),
                pw.Expanded(
                  child: images.length == 3
                      ? pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Image(
                              images[1],
                              width: PdfPageFormat.a4.width / 2,
                            ),
                            pw.Image(
                              images[2],
                              width: PdfPageFormat.a4.width / 2,
                            )
                          ],
                        )
                      : pw.Image(images[1]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool isOn0 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackground,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const DannyAvatar(),
              const SizedBox(height: 20),
              const Text(
                'Sharing is Caring',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ksecondary,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Wait a bit while I gather all your data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ksecondary.withOpacity(0.3),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: isOn0 ? 340 : MediaQuery.of(context).size.width * 0.66,
                child: Screenshot<dynamic>(
                  controller: screenshotController,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: widget.options.length,
                    itemBuilder: (context, i) {
                      if (widget.options[i] == 'Well-Being') {
                        return WellbeingGeneration(
                          pageController: pageControllerChildren[i],
                          type: widget.type,
                          range: widget.range,
                        );
                      }
                      return TrackerGeneration(
                        pageController: pageControllerChildren[i],
                        type: widget.type,
                        range: widget.range,
                        tracker: widget.options[i],
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 40),
              const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
