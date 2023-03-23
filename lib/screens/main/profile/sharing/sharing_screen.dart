import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/stats_pdf.dart';
import 'package:danny/services/background_service.dart';
import 'package:danny/services/firebase_auth_service.dart';
import 'package:danny/services/firebase_storage_service.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/buttons/goback_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/notifications/error_notification.dart';
import 'package:danny/widgets/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SharingScreen extends StatefulWidget {
  const SharingScreen({Key? key}) : super(key: key);

  @override
  _SharingScreenState createState() => _SharingScreenState();
}

class _SharingScreenState extends State<SharingScreen> {
  int selectedPdf = 0;
  late Future<StatsPdf?> pdf1;
  late Future<StatsPdf?> pdf2;

  Future<void> _refreshPDFs() async {
    pdf1 = _getPdfImage(context, '1');
    pdf2 = _getPdfImage(context, '2');
    setState(() {});
  }

  Future<StatsPdf?> _getPdfImage(BuildContext context, String id) async {
    final userId = Provider.of<FirebaseAuthService>(context, listen: false)
        .currentUser!
        .uid;
    final storage = Provider.of<FirebaseStorageService>(context, listen: false);

    final pdfDate = await storage.downloadPDF(userId, id);
    final directory = await getTemporaryDirectory();
    if (pdfDate == null) return null;

    final document =
        await PdfDocument.openFile('${directory.path}/stats$id.pdf');
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);

    await page.close();
    await document.close();

    if (pageImage == null) return null;
    return StatsPdf(
      date: pdfDate,
      image: MemoryImage(pageImage.bytes),
    );
  }

  Future<void> _openPDF(int id) async {
    final directory = await getTemporaryDirectory();
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewer(path: '${directory.path}/stats$id.pdf'),
      ),
    );
  }

  @override
  void initState() {
    _refreshPDFs();
    super.initState();
  }

  Future<void> _share(BuildContext scaffoldContext) async {
    if (selectedPdf == 0) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: ErrorNotification('No PDF selected'),
        ),
      );
      return;
    }
    Provider.of<BackgroundService>(context, listen: false).incShared();
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/stats$selectedPdf.pdf';

    await Share.shareFiles(
      [path],
      mimeTypes: ['application/pdf'],
      subject: 'Sharing Well-Being',
      text: 'Check out my well-being stats',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackground,
      body: SafeArea(
        child: Stack(
          children: [
            const GoBackButton(),
            Center(
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
                      'Here you can generate snapshots of your data to share with others',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ksecondary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 210 / 297,
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      '/generate',
                                    );
                                    Future.delayed(
                                      const Duration(milliseconds: 5000),
                                      _refreshPDFs,
                                    );
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.ksecondary
                                            .withOpacity(0.25),
                                      ),
                                    ),
                                    child: const Icon(
                                      CustomIcons.mais,
                                      size: 50,
                                      color: AppColors.kprimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'New..',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.ksecondary.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: FutureBuilder<StatsPdf?>(
                            future: pdf1,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              final pdf = snapshot.data;
                              final dateFormat = DateFormat('MMM d. yyyy');
                              return Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 210 / 297,
                                    child: pdf == null
                                        ? const ColoredBox(
                                            color: Colors.transparent,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              if (selectedPdf == 1) {
                                                _openPDF(1);
                                              } else {
                                                setState(() {
                                                  selectedPdf = 1;
                                                });
                                              }
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: selectedPdf == 1
                                                    ? Border.all(
                                                        color: AppColors
                                                            .ksecondary
                                                            .withOpacity(0.5),
                                                        width: 3,
                                                      )
                                                    : Border.all(
                                                        color: AppColors
                                                            .ksecondary
                                                            .withOpacity(
                                                          0.25,
                                                        ),
                                                      ),
                                                image: DecorationImage(
                                                  image: pdf.image,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    pdf == null
                                        ? ''
                                        : dateFormat
                                            .format(pdf.date)
                                            .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          AppColors.ksecondary.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: FutureBuilder<StatsPdf?>(
                            future: pdf2,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              final pdf = snapshot.data;
                              final dateFormat = DateFormat('MMM d. yyyy');
                              return Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 210 / 297,
                                    child: pdf == null
                                        ? const ColoredBox(
                                            color: Colors.transparent,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              if (selectedPdf == 2) {
                                                _openPDF(2);
                                              } else {
                                                setState(() {
                                                  selectedPdf = 2;
                                                });
                                              }
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: selectedPdf == 2
                                                    ? Border.all(
                                                        color: AppColors
                                                            .ksecondary
                                                            .withOpacity(0.5),
                                                        width: 3,
                                                      )
                                                    : Border.all(
                                                        color: AppColors
                                                            .ksecondary
                                                            .withOpacity(
                                                          0.25,
                                                        ),
                                                      ),
                                                image: DecorationImage(
                                                  image: pdf.image,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    pdf == null
                                        ? ''
                                        : dateFormat
                                            .format(pdf.date)
                                            .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          AppColors.ksecondary.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Select or create a new snapshot',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ksecondary.withOpacity(0.3),
                    ),
                  ),
                  const Spacer(flex: 10),
                  GenericButton(
                    title: 'Share',
                    onPressed: () => _share(context),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
