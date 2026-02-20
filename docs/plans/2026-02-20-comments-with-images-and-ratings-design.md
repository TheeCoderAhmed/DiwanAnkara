# Comments with Images and Ratings Design

## Overview
This design document covers adding the ability for users to upload up to 3 images and provide a 1-5 star rating when submitting a comment/review on entities like universities, hospitals, etc. It also includes an admin cleanup mechanism to delete associated images when a comment is deleted or rejected.

## Data Model Changes
**`Comment` model** (`lib/domain/models/comment.dart`):
* Add `List<String> imageUrls`
* Add `double rating` (or `int rating`)

Update `fromJson` and `toJson` accordingly.

## UI Updates
**`PublicReviewSection`** (`lib/ui/widgets/public_review_section.dart`):
* **Add Review Form:**
  * Add a 5-star interactive rating bar (using a package like `flutter_rating_bar` or custom UI) above the comment text field. Make it a required field.
  * Add an image picker button to select up to 3 images (`image_picker` package).
  * Display selected images as thumbnails below the text field. Allow removing them before submission.
* **Review Display:**
  * Show the star rating under the user's name in `_ReviewBubble`.
  * Display thumbnails of the attached images below the text in `_ReviewBubble`. Tapping opens them full screen (could use a simple dialog or existing image viewer).

## Upload & Submission Flow (Approach 1)
1. User interacts with the form and selects up to 3 images + a rating.
2. Upon tapping submit, a loading state is shown.
3. The app uploads each image to Firebase Storage at `reviews/{targetId}/{uuid}.jpg`.
4. The resulting download URLs are collected.
5. The `submitCommentProvider` or submission function is called with the text, rating, and image URLs.
6. The comment is saved to Firestore as "pending".
7. Form is cleared and success message shown.

## Admin Management & Cleanup
When an admin deletes or rejects a comment within the app:
1. The app logic retrieves the comment's `imageUrls`.
2. It calls Firebase Storage to delete each URL.
3. It deletes the comment document from Firestore.
*Note: Since the admin dashboard is outside this specific widget file, the logic should ideally reside in the `CommentRepository` or the admin specific provider handling comment deletion.*
