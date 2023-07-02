/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


const admin = require("firebase-admin");
const functions = require("firebase-functions");
// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

admin.initializeApp(functions.config().firebase);
const plusOne = 1;
const minusOne = -1;
const fireStore = admin.firestore();

exports.onFollowerCreate = functions.firestore.
    document("users/{uid}/followers/{followerUid}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await fireStore.collection("users").doc(newValue.followedUid).update({
            "followerCount": admin.firestore.FieldValue.increment(plusOne),
          });
          await fireStore.collection("users").doc(newValue.followerUid).update({
            "followingCount": admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );

exports.onFollowerDelete = functions.firestore.
    document("users/{uid}/followers/{followerUid}").onDelete(
        async (snap, _) => {
          const newValue = snap.data();
          await fireStore.collection("users").doc(newValue.followedUid).update({
            "followerCount": admin.firestore.FieldValue.increment(minusOne),
          });
          await fireStore.collection("users").doc(newValue.followerUid).update({
            "followingCount": admin.firestore.FieldValue.increment(minusOne),
          });
        },
    );


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });