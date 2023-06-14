import 'package:bill_invoice/Storage_Service/Firebase_Storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';

//Hata verdiği için burası çalışmıyor

class Calender {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Storage storage = Storage();

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      print('Signed in with Google! User: $user');
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> createCalendarEvent() async {
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "billpaymentapp-9bc6e",
      "private_key_id": "53f4477c1ef256ee53daad5cfd2787e659964bad",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDmTIKtOW+y+cFz\nwZaTmEQ7k62HqfbTVIfrzAMSZUKefU6GSH7d4V+n5xCRwQ35jlwSHYT6Zie3kLT/\n4TfgbxR7s1oQLD9y7BtZQ2dje0cK7q7B17CHfPH9Km6Bxv5QnWwuCqCyGOXMv9tf\ngHAb2WE2D4+RsdmcfBbh9k4FbBlH/5QrmhsIKbn1M8KSQ082BkfOZefuvkwwml8e\nfugPDia629Y6UBe2yS9TPjZ0flUZo3OcsgfSNlmasHaJ43XidrvnkmjAGG/nEjud\nUO6iX4Iq7NxH6IBx6BPY1VLLVUAWUwzzOAx+MaLgtNCrqDKcPydojdVLVfrwLLNW\nPglBhZpDAgMBAAECggEAGfRhfdhNSGRxcvRMXhH5DqXUFsgG80ZBk0eIyRf0bBw/\nL08YTTVLLIcUDPku9AMhSUFebUH6E+wRGg1t2LNsIYzTB6OU+wS1CFhaXJHWLds8\ngsgmMv7X3upbTfD5VGiJep7kAW5g57RvqtG00M6s8ATM72SV29b4VTsHDAFk0AI9\nG7MYwPPqLihhBR8Fnf3VvNeCbzIGQ/ndHKEkeHOCFTPRkgzUuncW6V2p7ENF7kDY\nmIFxTGZDuigkfnTFmmsCKS7TVirldbJdbEYELdRsFA7EUQ3L4KmTCapThHl7ep74\nF+MDqvgqkwkfZLhsMYr+RWfOvSdO1SlR2LaYLk69sQKBgQDz3u4upIRP6QkBHngO\nQ0kp31NdDDEh8as22/BWBiM2u6916Eh6jUMbFuYecAxGSC1PQ8wKRpY/F5HQG6Tu\nKTa8z5+cExv9yX+I9DgSMx8QYtfe/5G82FaG1TMsWtDr/WIDpMbV1MNAdL73yN0y\nDAV91xVye56CZT5OHsgmk0vUFQKBgQDxwMaqU0Ns4xwoV01F53VhOHB/JTjAZMdU\nZmL/yHNXZejU2jr0C4Osp8VMSZX1iF71pde3m06UFeAZwkk0FQJIAwx/1ZmJ3zDZ\nHHcwu8KzV4u43p8aKkJT/WqnI76g5pl1w1jlw/yThza3Vx5upTAsA+pX9s/Ng166\njIBSZMiS9wKBgD6NTfa0yCNfGKoq0IyIAbo1yEIzoF6eiFYX7/uAs4OUfJr3q6+T\nkETgiMIB54QXe1e7ghiYpm0kdIg2rwVPmPSxJLV5yVI9XvMYAVHZvvwK/mf6kb0o\nmHkZMnkMCk6dvYhFuaKbYkGkMF+KLAJsRvRSOPQWdT/pDCQpjRkn6ulJAoGAa0Fv\n4plWTLTmBS/WZLEv7pYvsvk8mH8dwGA8g+bW5WudRPIdPbDuFmfIrPPoyCpclveh\nISCSWDjsWAFOoQDBJlnT7dNCb1zKO0jZyJFE7HRm1PpP9DfTfZfs/YJqTNCCPTER\n+75cDMfsiqLoKYa4PI7wJV6nCzLBkFpNhECajDkCgYACHH2q9c33h3s5LvUsWyBB\nVTGBCurJ+SnI58wbYAphU8VHjq7YPJgH+Faj+Pv3kJlnGe2CCrof6VZqt1dVN3OP\nAyFjiNJmn2aF0t3SIsrzE7UUBAtoHJM0kOgu9heYGqSc+Z9EJ8+axcTok90KkA0f\nrzrgEFZxRKd06RAepie8mg==\n-----END PRIVATE KEY-----\n",
      "client_email": "billpaymentapp-9bc6e@appspot.gserviceaccount.com",
      "client_id": "112573682762935460808",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/billpaymentapp-9bc6e%40appspot.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });

    final scopes = [calendar.CalendarApi.calendarScope];
    final client = await clientViaServiceAccount(credentials, scopes);

    final calendarApi = calendar.CalendarApi(client);
    final event = calendar.Event()
      ..summary = 'Flutter Event'
      ..start = calendar.EventDateTime(dateTime: DateTime.now())
      ..end = calendar.EventDateTime(
          dateTime: DateTime.now().add(const Duration(hours: 1)));

    // Get the authenticated user
    final User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Kullanıcının takvimlerini alın
        final calendarList = await calendarApi.calendarList.list();

        // Kullanıcının takvimlerini dönerek doğru takvimin ID'sini bulun
        for (final calendarItem in calendarList.items ?? []) {
          if (calendarItem.id!.contains(user.uid)) {
            final calendarId = '${calendarItem.id}';
            final createdEvent =
                await calendarApi.events.insert(event, calendarId);

            print('Event created: ${createdEvent.htmlLink}');
          }
        }

        print('Kullanıcının takvimi bulunamadı');
        return null;
      } catch (e) {
        print('Takvim ID alınamadı: $e');
        return null;
      }
      // Set the Google ID token in the service account credentials
    }

    client.close();
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // Future<void> signInWithGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //       scopes: ['email', 'https://www.googleapis.com/auth/calendar']);
  //
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuth =
  //         await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuth.accessToken,
  //       idToken: googleSignInAuth.idToken,
  //     );
  //
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //
  //     // Giriş yapan kullanıcının takvim ID'sini almak için aşağıdaki fonksiyonu çağırın
  //     final String? calendarId = await getCalendarId(userCredential.user!.uid);
  //
  //     if (calendarId != null) {
  //       await addEventToCalendar(calendarId);
  //     } else {
  //       print("${calendarId}boş");
  //     }
  //   } catch (e) {
  //     print('Google Yetkilendirme Hatası: $e');
  //   }
  // }
  //
  // Future<String?> getCalendarId(String userId) async {
  //   const scopes = [calendar.CalendarApi.calendarScope];
  //   final accountCredentials = ServiceAccountCredentials.fromJson({
//       "type": "service_account",
//       "project_id": "billpaymentapp-9bc6e",
//       "private_key_id": "53f4477c1ef256ee53daad5cfd2787e659964bad",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDmTIKtOW+y+cFz\nwZaTmEQ7k62HqfbTVIfrzAMSZUKefU6GSH7d4V+n5xCRwQ35jlwSHYT6Zie3kLT/\n4TfgbxR7s1oQLD9y7BtZQ2dje0cK7q7B17CHfPH9Km6Bxv5QnWwuCqCyGOXMv9tf\ngHAb2WE2D4+RsdmcfBbh9k4FbBlH/5QrmhsIKbn1M8KSQ082BkfOZefuvkwwml8e\nfugPDia629Y6UBe2yS9TPjZ0flUZo3OcsgfSNlmasHaJ43XidrvnkmjAGG/nEjud\nUO6iX4Iq7NxH6IBx6BPY1VLLVUAWUwzzOAx+MaLgtNCrqDKcPydojdVLVfrwLLNW\nPglBhZpDAgMBAAECggEAGfRhfdhNSGRxcvRMXhH5DqXUFsgG80ZBk0eIyRf0bBw/\nL08YTTVLLIcUDPku9AMhSUFebUH6E+wRGg1t2LNsIYzTB6OU+wS1CFhaXJHWLds8\ngsgmMv7X3upbTfD5VGiJep7kAW5g57RvqtG00M6s8ATM72SV29b4VTsHDAFk0AI9\nG7MYwPPqLihhBR8Fnf3VvNeCbzIGQ/ndHKEkeHOCFTPRkgzUuncW6V2p7ENF7kDY\nmIFxTGZDuigkfnTFmmsCKS7TVirldbJdbEYELdRsFA7EUQ3L4KmTCapThHl7ep74\nF+MDqvgqkwkfZLhsMYr+RWfOvSdO1SlR2LaYLk69sQKBgQDz3u4upIRP6QkBHngO\nQ0kp31NdDDEh8as22/BWBiM2u6916Eh6jUMbFuYecAxGSC1PQ8wKRpY/F5HQG6Tu\nKTa8z5+cExv9yX+I9DgSMx8QYtfe/5G82FaG1TMsWtDr/WIDpMbV1MNAdL73yN0y\nDAV91xVye56CZT5OHsgmk0vUFQKBgQDxwMaqU0Ns4xwoV01F53VhOHB/JTjAZMdU\nZmL/yHNXZejU2jr0C4Osp8VMSZX1iF71pde3m06UFeAZwkk0FQJIAwx/1ZmJ3zDZ\nHHcwu8KzV4u43p8aKkJT/WqnI76g5pl1w1jlw/yThza3Vx5upTAsA+pX9s/Ng166\njIBSZMiS9wKBgD6NTfa0yCNfGKoq0IyIAbo1yEIzoF6eiFYX7/uAs4OUfJr3q6+T\nkETgiMIB54QXe1e7ghiYpm0kdIg2rwVPmPSxJLV5yVI9XvMYAVHZvvwK/mf6kb0o\nmHkZMnkMCk6dvYhFuaKbYkGkMF+KLAJsRvRSOPQWdT/pDCQpjRkn6ulJAoGAa0Fv\n4plWTLTmBS/WZLEv7pYvsvk8mH8dwGA8g+bW5WudRPIdPbDuFmfIrPPoyCpclveh\nISCSWDjsWAFOoQDBJlnT7dNCb1zKO0jZyJFE7HRm1PpP9DfTfZfs/YJqTNCCPTER\n+75cDMfsiqLoKYa4PI7wJV6nCzLBkFpNhECajDkCgYACHH2q9c33h3s5LvUsWyBB\nVTGBCurJ+SnI58wbYAphU8VHjq7YPJgH+Faj+Pv3kJlnGe2CCrof6VZqt1dVN3OP\nAyFjiNJmn2aF0t3SIsrzE7UUBAtoHJM0kOgu9heYGqSc+Z9EJ8+axcTok90KkA0f\nrzrgEFZxRKd06RAepie8mg==\n-----END PRIVATE KEY-----\n",
//       "client_email": "billpaymentapp-9bc6e@appspot.gserviceaccount.com",
//       "client_id": "112573682762935460808",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/billpaymentapp-9bc6e%40appspot.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     });
  //   final client = await clientViaServiceAccount(accountCredentials, scopes);
  //   final calendarApi = calendar.CalendarApi(client);
  //
  //   try {
  //     // Kullanıcının takvimlerini alın
  //     final calendarList = await calendarApi.calendarList.list();
  //
  //     // Kullanıcının takvimlerini dönerek doğru takvimin ID'sini bulun
  //     for (final calendarItem in calendarList.items ?? []) {
  //       if (calendarItem.id!.contains(userId)) {
  //         return calendarItem.id;
  //       }
  //     }
  //
  //     print('Kullanıcının takvimi bulunamadı');
  //     return null;
  //   } catch (e) {
  //     print('Takvim ID alınamadı: $e');
  //     return null;
  //   }
  // }
  //
  // Future<void> addEventToCalendar(String calendarId) async {
  //   final calendar.Event event = calendar.Event();
  //
  //   event.summary = 'Yeni Etkinlik';
  //   event.description = 'Bu etkinlik Flutter ile takvime eklendi.';
  //   event.start = calendar.EventDateTime(dateTime: DateTime.now());
  //   event.end = calendar.EventDateTime(
  //       dateTime: DateTime.now().add(Duration(hours: 1)));
  //
  //   final calendarApi = await getClient();
  //
  //   try {
  //     final createdEvent = await calendarApi.events.insert(event, calendarId);
  //     print('Etkinlik oluşturuldu: ${createdEvent.htmlLink}');
  //   } catch (e) {
  //     print('Etkinlik eklenirken hata oluştu: $e');
  //   }
  // }
  //
  // Future<calendar.CalendarApi> getClient() async {
  //   final accountCredentials = ServiceAccountCredentials.fromJson({
  //     "type": "service_account",
  //     "project_id": "billpaymentapp-9bc6e",
  //     "private_key_id": "f8740aa6ef051f1d1ccd03415ba5c8cc7cb4f34b",
  //     "private_key":
  //         "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDWl1Df1IphrwOz\nX06z3g6i6TaKQJM4l9A5OyBBfmNLKvhKuPLyDg1a4jsJtVgPXuGIBlYQhfbflDLp\nd23Lo/t1ntWB2cvj7A/lV0gHJpdo0k+SKz+ahBnlMRWTrgdUbO4i6HW6dGDWuOzH\nRH6FLIfikcYohEYiDDGupik4iqsJGZwqNw+7FTiQW/tw+2Iu+LYQozZzLAfLHc9k\nZ8lUVGp6safpz1CmPaToykZtLqp42d8mWDTL8/SALsgmrPr4KTrBAxcQcRjp+ng5\nSM7yFjn5tK3zim+tNfIbKaKmN0DRf9jB30X1jW6VvphC9KowTq6nG/9ZS6gBd6Lf\n4DCLDmwDAgMBAAECggEARQ7EEYwiDmaWn8prlvm+pxG7Igm+9wbwFQLgkgMc7CtD\nZTSYxmncRWOpkSnBUYz8slwrpTyfYnscWUK8XD0E5ui7GAMhmNM2mF0aymZScoK/\n5a+yU8TwWnAN3A00wageiLBbdqoOIfu4AzaZKr1Wa4TzCsXqlflroaNKf64sdYwn\nmBe12cOlKCNHo89CNMJ/AnMe2Aag7dG3De3UTI6qEKMSRVrrO1xen8luXaBKECWk\nbFnxfyamfM+AdP7nC/mLJWvyuUYNk5L+EhBiMf/VUTAUh4fJdUOpnAHhld72TTbt\nP6egHySTGkSezexagDhWbyrYq9uXL05GCEg3UyDPVQKBgQD7kUkKtJHp6KKwWNtj\n8bLC74RCqHnMyblBHDvtggbU2Sn006FE3x0XI0ciuPnXnHNtsoIOGf3FrIKIYgB/\nzWNFjvKb+johMeV5aHlW3QxAzpsrc4aMO5rU2n63eD3FJz+y/Z3uKkpFSf4rdcFe\nKJfEjAHjXbkLrTxcPhAqQmbLPwKBgQDaXz7ZLsTqPR8B/0LcHNf7EYJ4NhniiXvy\nk+1R8HqfJlN2zabqtDoP9SEuv7xYEOITW4Ty26RvzxpbcwpL5w2oDtULZQ4Ik9MQ\nrq89NRoBBYC/kNph02O3mwSpPGZx/q5O0q7YFDqCiBNdPWpymrWsrK8KXiTA8GIs\ntEvHJiaCPQKBgQC8uveQV32sfYIoSNF2/qo9AtI37AtMrv4TsennuogDgVSvv2Ga\nuMQrSqUgkKOntVEHuEdH6wnvFgfr55I2T1EtqxuqFyUrKDLfTZjSqQ17RUU2aPpF\nFKaJD87HOCcnVNW+I/Uq64FC0EsmMba7PDr4Eo2MFRExiGrjTRB1k9FoowKBgCzf\nY4/Hb4les+96H6gReURLTc8b9ue5LrIjOaIb02a+vmnsSn9yN3gt+/qaRb6nAX3O\n0ZwCDGE5YoYmNphwSzsciSTFSEP09Gs6KiJethA9rD4xKt7tTFFfVm7cTYThO7pQ\nysL2LSvDgI8pXqVcKzbnaTStMco/2zyqc+PhcApVAoGBAMZ4JdyF1fl1aK8gY6Uq\netBdGEGEImeSaipwIeRLh34H3pIHSzGoYqZ1SnL6dUJR3h8PtjAZTpSRwuNneYdA\nNPT6S1iD/pqC3JLLe0uyxjnva5eDoI22YxFDlFkKYlhvU6QqBtcdVdeHL1BDsThQ\n07MV2b4Elq+FDvdt9439If1z\n-----END PRIVATE KEY-----\n",
  //     "client_email":
  //         "firebase-adminsdk-blkaj@billpaymentapp-9bc6e.iam.gserviceaccount.com",
  //     "client_id": "114776487979759105400",
  //     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  //     "token_uri": "https://oauth2.googleapis.com/token",
  //     "auth_provider_x509_cert_url":
  //         "https://www.googleapis.com/oauth2/v1/certs",
  //     "client_x509_cert_url":
  //         "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-blkaj%40billpaymentapp-9bc6e.iam.gserviceaccount.com",
  //     "universe_domain": "googleapis.com"
  //   });
  //   final scopes = [calendar.CalendarApi.calendarScope];
  //   final client = await clientViaServiceAccount(accountCredentials, scopes);
  //   print(client);
  //   return calendar.CalendarApi(client);
  // }
}
