const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().functions);

exports.addItemChanges = functions.firestore
  .document("/{collection}/{id}")
  .onCreate((change, context) => {
    // Retrieve the current and previous value
    const data = change.data();
    const collection = context.params.collection;

    var v = { userId: data.userId };
    var addedAmount = admin.firestore.FieldValue.increment(Number(data.amount));
    var deductedAmount = admin.firestore.FieldValue.increment(
      -Number(data.amount)
    );
    if (collection == "expenses") {
      v.expense = addedAmount;
    } else if (collection == "debts" && data.isPaid) {
      v.paidDebt = addedAmount;
      v.unpaidDebt = deductedAmount;
    } else if (collection == "debts" && !data.isPaid) {
      v.unpaidDebt = addedAmount;
      /*  var notificationData = data;
      notificationData.read = false;
      admin.firestore().collection("notification").add(notificationData); */
    }

    return admin
      .firestore()
      .collection("profile")
      .doc(data.userId)
      .set(v, { merge: true });
  });

exports.updateItemChanges = functions.firestore
  .document("/{collection}/{id}")
  .onUpdate((change, context) => {
    // Retrieve the current and previous value
    const data = change.after.data();
    const previousData = change.before.data();
    const collection = context.params.collection;

    if (
      data.isPaid != previousData.isPaid /* ||
      data.amount != previousData.amount */
    ) {
      var v = { userId: data.userId };
      var addedAmount = admin.firestore.FieldValue.increment(
        Number(data.amount)
      );
      var deductedAmount = admin.firestore.FieldValue.increment(
        -Number(data.amount)
      );
      if (collection == "expenses") {
        v.expense = addedAmount;
      } else if (collection == "debts" && data.isPaid) {
        v.paidDebt = addedAmount;
        v.unpaidDebt = deductedAmount;
      } else if (collection == "debts" && !data.isPaid) {
        v.unpaidDebt = addedAmount;
      }
      return admin
        .firestore()
        .collection("profile")
        .doc(data.userId)
        .set(v, { merge: true });
    } else if (data.amount != previousData.amount) {
      var v = { userId: data.userId };
      var val = data.amount - previousData.amount;
      var updatedAmount = admin.firestore.FieldValue.increment(Number(val));

       if (collection == "expenses") {
         v.expense = updatedAmount;
       }else if (collection == "debts" && data.isPaid) {
        v.paidDebt = updatedAmount;
      } else if (collection == "debts" && !data.isPaid) {
        v.unpaidDebt = updatedAmount;
      }

      return admin
        .firestore()
        .collection("profile")
        .doc(data.userId)
        .set(v, { merge: true });
    }
  });

exports.scheduledFunction = functions.pubsub
  .schedule("0 12 * * 1-7")
  .timeZone("Africa/Lagos")
  .onRun((context) => {
    var today = new Date();

    admin
      .firestore()
      .collection("debts")

      .where("isPaid", "==", false)
      //  .where("payOffBy", "==", Date(today.getFullYear(), today.getMonth(), today.getDate()))
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          admin
            .firestore()
            .collection("profile")
            .doc(doc.data().userId)
            .get()
            .then((e) => {
              console.log(doc.data().payOffBy);
              const payload = {
                notification: {
                  title: "Debt Reminder",
                  body: `${doc.data().debtorName} debt is due today`,
                },
                data: {
                  debtId: doc.id,
                },
              };
              admin.messaging().sendToDevice(e.data().deviceToken, payload);
            });
          console.log(
            "At 22:00 on every day-of-week from Monday through Sunday."
          );
        });
        return null;
      });
  });
