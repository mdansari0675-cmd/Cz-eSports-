# AxiovaX Firestore Database Schema

## Complete Collections & Document Structure

### 1. **USERS COLLECTION**
Path: `/users/{userId}`

```json
{
  "userId": "user123",
  "email": "user@example.com",
  "phone": "+919876543210",
  "displayName": "Player Name",
  "profilePicture": "https://...",
  "deviceIds": ["device_id_1", "device_id_2"],
  "inGameIds": {
    "bgmi": "BGMI_Username",
    "freefire": "FF_Username",
    "ludo": "Ludo_Username"
  },
  "walletBalance": 5000,
  "totalEarnings": 25000,
  "totalWinnings": 8,
  "totalMatches": 20,
  "accountStatus": "active", // active, suspended, banned
  "kycStatus": "verified", // pending, verified, rejected
  "kycDocument": {
    "type": "aadhar", // aadhar, pan
    "number": "xxxx xxxx xxxx",
    "verificationDate": "2025-01-15T10:30:00Z"
  },
  "bankDetails": {
    "accountHolderName": "User Name",
    "accountNumber": "xxxx xxxx xxxx",
    "ifscCode": "SBIN0001234",
    "upiId": "user@upi"
  },
  "createdAt": "2025-01-01T10:00:00Z",
  "updatedAt": "2025-01-15T10:30:00Z",
  "lastLoginAt": "2025-01-15T10:30:00Z",
  "isAdmin": false
}
```

---

### 2. **TOURNAMENTS COLLECTION**
Path: `/tournaments/{tournamentId}`

```json
{
  "tournamentId": "tournament_123",
  "name": "BGMI Squad Tournament",
  "description": "Weekly BGMI squad battle",
  "gameType": "bgmi", // bgmi, freefire, ludo, etc.
  "gameMode": "squad", // solo, duo, squad
  "status": "upcoming", // upcoming, live, completed, cancelled
  "entryFee": 500,
  "prizePool": {
    "totalPrize": 50000,
    "distribution": {
      "1st": 30000,
      "2nd": 15000,
      "3rd": 5000
    }
  },
  "perKillBonus": 500, // or null if not applicable
  "totalSlots": 50,
  "registeredPlayers": 35,
  "slotsLeft": 15,
  "map": "Erangle", // or specific map
  "scheduledTime": "2025-01-20T18:00:00Z",
  "registrationDeadline": "2025-01-20T17:30:00Z",
  "matchStartTime": "2025-01-20T18:00:00Z",
  "matchEndTime": "2025-01-20T20:30:00Z",
  "roomDetails": {
    "roomId": "12345678",
    "password": "ABCD1234",
    "ludoCode": null,
    "revealTime": "2025-01-20T17:45:00Z", // 15 min before match
    "isRevealed": false
  },
  "registeredPlayersList": ["user1", "user2", "user3"],
  "results": {
    "declared": false,
    "winners": [
      {
        "rank": 1,
        "userId": "user1",
        "prizeAmount": 30000,
        "prizeDistributed": false
      }
    ]
  },
  "createdBy": "admin_user_123",
  "createdAt": "2025-01-15T10:00:00Z",
  "updatedAt": "2025-01-15T10:30:00Z"
}
```

---

### 3. **TOURNAMENT_REGISTRATIONS COLLECTION**
Path: `/tournaments/{tournamentId}/registrations/{userId}`

```json
{
  "userId": "user123",
  "tournamentId": "tournament_123",
  "registrationDate": "2025-01-18T14:30:00Z",
  "entryFeeDeducted": true,
  "entryFeeAmount": 500,
  "transactionId": "txn_123456",
  "status": "registered", // registered, completed, cancelled
  "participantInGameId": "BGMI_Username",
  "resultSubmitted": false,
  "resultImageUrl": null,
  "resultStatus": "pending", // pending, approved, rejected
  "adminReviewedAt": null,
  "adminReviewedBy": null,
  "killCount": null,
  "finalRank": null,
  "prizeWon": null,
  "prizeDistributed": false,
  "prizeDistributedAt": null
}
```

---

### 4. **WALLET COLLECTION**
Path: `/wallets/{userId}`

```json
{
  "userId": "user123",
  "balance": 15000,
  "totalDeposited": 50000,
  "totalWithdrawn": 35000,
  "totalWon": 25000,
  "totalSpent": 10000,
  "lastUpdatedAt": "2025-01-15T10:30:00Z"
}
```

---

### 5. **WALLET_TRANSACTIONS COLLECTION**
Path: `/wallets/{userId}/transactions/{transactionId}`

```json
{
  "transactionId": "txn_123456",
  "userId": "user123",
  "type": "deposit", // deposit, withdrawal, entry_fee, prize_won, refund
  "amount": 5000,
  "status": "completed", // pending, completed, failed, cancelled
  "paymentMethod": "razorpay", // razorpay, cashfree, manual_transfer
  "razorpayPaymentId": "pay_123456",
  "razorpayOrderId": "order_123456",
  "upiId": "user@upi",
  "bankDetails": {
    "accountNumber": "xxxx xxxx xxxx",
    "ifscCode": "SBIN0001234"
  },
  "tournamentId": null, // populated only for entry_fee and prize_won
  "description": "Deposit via UPI",
  "createdAt": "2025-01-15T10:30:00Z",
  "completedAt": "2025-01-15T10:35:00Z",
  "failureReason": null
}
```

---

### 6. **WITHDRAWAL_REQUESTS COLLECTION**
Path: `/withdrawalRequests/{requestId}`

```json
{
  "requestId": "wr_123456",
  "userId": "user123",
  "amount": 5000,
  "upiId": "user@upi",
  "bankDetails": {
    "accountHolderName": "User Name",
    "accountNumber": "xxxx xxxx xxxx",
    "ifscCode": "SBIN0001234"
  },
  "withdrawalMethod": "upi", // upi, bank_transfer
  "status": "pending", // pending, approved, rejected, completed
  "requestDate": "2025-01-15T10:30:00Z",
  "approvedAt": null,
  "approvedBy": null,
  "completedAt": null,
  "rejectionReason": null,
  "transactionId": null,
  "remarks": null
}
```

---

### 7. **DISPUTES COLLECTION**
Path: `/disputes/{disputeId}`

```json
{
  "disputeId": "dispute_123",
  "tournamentId": "tournament_123",
  "userId": "user123",
  "type": "result_verification", // result_verification, prize_not_received, unfair_play
  "status": "open", // open, investigating, resolved, rejected
  "description": "Screenshot shows victory but not ranked correctly",
  "screenshotUrl": "https://...",
  "additionalProof": ["https://...", "https://..."],
  "reportedAt": "2025-01-15T10:30:00Z",
  "assignedTo": "admin_user_123",
  "resolvedAt": null,
  "resolution": null, // admin's final decision
  "prizeAdjustment": null, // if prize needs to be adjusted
  "comments": []
}
```

---

### 8. **ADMIN_AUDIT_LOG COLLECTION**
Path: `/adminAuditLogs/{logId}`

```json
{
  "logId": "log_123456",
  "adminUserId": "admin_123",
  "action": "tournament_created", // or other actions
  "entityType": "tournament", // tournament, user, withdrawal, etc.
  "entityId": "tournament_123",
  "changes": {
    "field": "status",
    "oldValue": "upcoming",
    "newValue": "live"
  },
  "timestamp": "2025-01-15T10:30:00Z",
  "ipAddress": "192.168.1.1",
  "userAgent": "Mozilla/5.0..."
}
```

---

### 9. **DEVICE_TRACKING COLLECTION**
Path: `/deviceTracking/{deviceId}`

```json
{
  "deviceId": "device_123abc",
  "userIds": ["user123", "user456"],
  "lastUsedUserId": "user123",
  "firstSeenAt": "2025-01-01T10:00:00Z",
  "lastSeenAt": "2025-01-15T10:30:00Z",
  "deviceInfo": {
    "model": "iPhone 14",
    "osVersion": "17.2",
    "appVersion": "1.0.0"
  },
  "isSuspicious": false,
  "accountsLinked": 2
}
```

---

### 10. **NOTIFICATIONS COLLECTION**
Path: `/notifications/{userId}/messages/{notificationId}`

```json
{
  "notificationId": "notif_123",
  "userId": "user123",
  "type": "tournament_reminder", // tournament_reminder, prize_won, withdrawal_approved, etc.
  "title": "Tournament Starting Soon!",
  "body": "BGMI Squad Tournament starts in 15 minutes",
  "data": {
    "tournamentId": "tournament_123"
  },
  "isRead": false,
  "createdAt": "2025-01-15T17:45:00Z"
}
```

---

## Firestore Indexes (Auto-created)

For optimal query performance, create these composite indexes:

1. **Tournaments Collection**
   - `gameType` + `status` + `scheduledTime`
   - `status` + `scheduledTime`

2. **Tournament Registrations**
   - `tournamentId` + `status` + `registrationDate`

3. **Wallet Transactions**
   - `userId` + `type` + `createdAt`
   - `userId` + `status` + `createdAt`

4. **Withdrawal Requests**
   - `userId` + `status` + `requestDate`
   - `status` + `requestDate`

---

## Security Rules (Firestore)

See `firestore.rules` for complete security implementation.

---
