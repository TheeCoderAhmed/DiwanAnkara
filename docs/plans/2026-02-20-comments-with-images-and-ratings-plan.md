# Comments with Images and Ratings Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Modify the comment system to allow users to add a 1-5 star rating and upload up to 3 images, storing these in Firebase Storage and Firestore.

**Architecture:** We will update the `Comment` model to include `imageUrls` and `rating`. In the UI, we'll use `image_picker` to select images and `firebase_storage` to upload them. On the display side, we'll show star icons and thumbnail previews of uploaded images. Admin rejection flows will also be updated to clean up attached images from storage.

**Tech Stack:** Flutter, Firebase Firestore, Firebase Storage, `image_picker`

---

### Task 1: Update Data Model and Storage Provider

**Files:**
- Modify: `lib/domain/models/comment.dart`
- Modify: `lib/data/firestore/firestore_providers.dart`
- Modify: `lib/data/firestore/firestore_repository.dart`

**Step 1: Check pubspec for image_picker and firebase_storage**
Wait, we need to make sure `image_picker` and `firebase_storage` are in `pubspec.yaml`. If not, we run `flutter pub add image_picker firebase_storage`. Also `uuid` seems to be added already.

**Step 2: Update Comment Model**

Update the `Comment` class in `lib/domain/models/comment.dart`:
Add `final List<String> imageUrls;` and `final double rating;` (or `int`).
Update `Comment.fromJson` and `toJson`.

**Step 3: Update `submitComment` provider**

Update `submitCommentProvider` in `lib/data/firestore/firestore_providers.dart` and `FirestoreRepository.addComment` to optionally take `imageUrls` and `rating` and pass them to the `Comment`. Keep default rating = 0 or 5 if you prefer for backwards compatibility.

---

### Task 2: Implement UI for Choosing Rating and Images

**Files:**
- Modify: `lib/ui/widgets/public_review_section.dart`

**Step 1: Add state variables for the form**
In `_PublicReviewSectionState`, add `List<XFile> _selectedImages = [];` and `int _rating = 0;`. Don't forget importing `image_picker`.

**Step 2: Create UI elements for Rating and Image Picker**
In `_buildReviewForm`, above the Name Field, add a row of 5 clickable stars to set `_rating`. Ensure validation checks that `_rating > 0`.
Add an "Add Photo" button row. Restrict to 3 max.
Add a row below the comment text field to display thumbnails of `_selectedImages` with remove icons.

**Step 3: Implement Image Upload Logic**
In `_submitReview`, before submitting to `submitCommentProvider`, upload the images to Firebase Storage. 

```dart
final List<String> uploadedUrls = [];
for (var image in _selectedImages) {
  // upload logic using FirebaseStorage
}
```

Wait, we should add `FirebaseStorage` imports and logic inside `_submitReview` (or extract to a helper method).

---

### Task 3: Display Rating and Images in Reviews

**Files:**
- Modify: `lib/ui/widgets/public_review_section.dart`

**Step 1: Show Star Rating**
In `_ReviewBubble`, extract the rating and show a row of star icons below the user name (or on the right side). Handle the case where `rating` is 0 (old comments).

**Step 2: Show Attached Images**
In `_ReviewBubble`, at the bottom of the review text, check if `review.imageUrls` is not empty. If not, build a horizontal row or wrap of thumbnails using `CachedNetworkImage`. Tap an image to view in a simple full-screen pop-up or dialog.

---

### Task 4: Add Image Storage Cleanup on Comment Deletion

**Files:**
- Find and Modify: Admin comment review/deletion logic. (Most likely in an admin panel file, `admin_dashboard_screen.dart`, or wherever comments are rejected).

**Step 1: Delete images before deleting Doc**
When a comment is deleted/rejected, iterate through `comment.imageUrls` (if any), create a `FirebaseStorage` reference from the URL, and call `.delete()`.

**Step 2: Handle edge cases**
Implement try/catch block for storage deletion. If image does not exist, it shouldn't crash the deletion of the Firestore document.
