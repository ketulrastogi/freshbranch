import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

exports.onUserCreate = functions.auth.user().onCreate((user) => {
    return admin.firestore().collection('users').doc(user.uid).set({
        uid: user.uid,
        role: 'customer',
        email: (user.email === undefined) ? '' : user.email,
        emailVerified: user.emailVerified,
        phone: (user.phoneNumber === undefined) ? '' : user.phoneNumber,
        createdOn: admin.firestore.FieldValue.serverTimestamp(),
        disabled: user.disabled
    });
});
