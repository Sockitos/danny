import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(String imageId, File image) async {
    final ref = _firebaseStorage.ref().child('profilepics/$imageId.jpg');
    final uploadTask = ref.putFile(image);
    return (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }

  Future<String> uploadRatingImage(
    String uid,
    String rid,
    File image,
    int index,
  ) async {
    final ref =
        _firebaseStorage.ref().child('ratingpics/uid/${rid}_$index.jpg');
    final uploadTask = ref.putFile(image);
    return (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }

  Future<void> uploadPdf(String pdfId, Uint8List pdf) async {
    final ref1 = _firebaseStorage.ref().child('pdfs/${pdfId}_1.pdf');
    final ref2 = _firebaseStorage.ref().child('pdfs/${pdfId}_2.pdf');
    UploadTask uploadTask;

    try {
      final meta = await ref1.getMetadata();
      uploadTask = ref2.putData(
        (await ref1.getData())!,
        SettableMetadata(
          contentLanguage: 'en',
          contentType: 'application/pdf',
          customMetadata: <String, String>{
            'generation': meta.customMetadata!['generation']!,
          },
        ),
      );
      await uploadTask.whenComplete(() => null);
    } catch (e) {
      log('Shifting PDFs');
    }

    uploadTask = ref1.putData(
      pdf,
      SettableMetadata(
        contentLanguage: 'en',
        contentType: 'application/pdf',
        customMetadata: <String, String>{
          'generation': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      ),
    );
    await uploadTask.whenComplete(() => null);
  }

  Future<DateTime?> downloadPDF(String userId, String id) async {
    final ref = _firebaseStorage.ref().child('pdfs/${userId}_$id.pdf');
    final directory = await getTemporaryDirectory();
    final tempFile = File('${directory.path}/stats$id.pdf');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();

    try {
      final meta = await ref.getMetadata();
      final date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(meta.customMetadata!['generation']!),
      );
      final downloadTask = ref.writeToFile(tempFile);
      await downloadTask.whenComplete(() => null);
      return date;
    } catch (e) {
      log('Error downloading PDF');
    }
    return null;
  }
}
