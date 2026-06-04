<div align="center">
<a href="https://pub.dev/packages/hdr_utils"><img src="https://img.shields.io/pub/v/hdr_utils.svg" /></a>
<a href="https://opensource.org/licenses/MIT" target="_blank"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"/></a>
<a href="https://github.com/Harshit2027/hdr_utils/issues" target="_blank"><img alt="GitHub Issues" src="https://img.shields.io/github/issues-raw/Harshit2027/hdr_utils?style=flat" /></a>
<img src="https://img.shields.io/github/last-commit/Harshit2027/hdr_utils" />
<a href="https://github.com/Harshit2027/hdr_utils"><img src="https://img.shields.io/github/stars/Harshit2027/hdr_utils?style=social" /></a>
</div>

---

## ❤️ Show some love and support the project

### Star the Repository
If you find this package useful, please star the repository on [GitHub](https://github.com/Harshit2027/hdr_utils) to show your support! ⭐

---

## 📱 Platform Support

| Android | iOS | Web |
| :-----: | :-: | :-: |
|   ✔️    | ✔️  | ✔️  |

---

## 📦 Installation

Add this package to `pubspec.yaml` as follows:

```console
$ flutter pub add hdr_utils
```

Import package:

```dart
import 'package:hdr_utils/hdr_utils.dart';
```

---

## 📋 Contents

- [🧩 Widgets](#-widgets)
  - [HdrTextField](#hdrtextfield)
  - [HdrImagePickerBuilder](#hdrimagepickerbuilder)
  - [HdrCustomShimmer](#hdrcustomshimmer)
  - [HdrSkeletonShimmer](#hdrskeletonshimmer)
- [🛠️ Utilities](#️-utilities)
  - [ValidatorUtils](#validatorutils)
  - [DialogUtils](#dialogutils)
  - [ImagePickerUtils](#imagepickerutils)
  - [LoggerUtils](#loggerutils)
  - [RegExpUtils](#regexputils)
- [⚡ Extensions](#-extensions)
  - [BuildContext Extensions](#buildcontext-extensions)
  - [DateTime Extensions](#datetime-extensions)
  - [List & Iterable Extensions](#list--iterable-extensions)
  - [Number & Double Extensions](#number--double-extensions)
  - [Color Extensions](#color-extensions)
  - [String Extensions](#string-extensions)

---

## 🧩 Widgets

### HdrTextField
A highly polished Material 3 text field with built-in validation displays, borders, custom padding, and automatic tap-outside keyboard unfocus.
```dart
HdrTextField(
  controller: emailController,
  labelText: "Email Address",
  hintText: "Enter your email",
  prefixIcon: Icon(Icons.email_outlined),
  keyboardType: TextInputType.emailAddress,
  validator: (val) => ValidatorUtils.validateEmailAddress(val),
);
```

### HdrImagePickerBuilder
Renders local image bytes (via `XFile`) or cached network URLs under customizable dimensions and shapes.
```dart
HdrImagePickerBuilder(
  localImage: selectedImageFile,
  imageUrl: "https://example.com/avatar.png",
  width: 120,
  height: 120,
  shape: CircleBorder(),
  placeholderBuilder: (context) => Icon(Icons.person, size: 40),
  onTap: () {
    // Trigger image picker
  },
);
```

### HdrCustomShimmer
Wraps any custom widget child and applies a smooth loading shimmer gradient.
```dart
HdrCustomShimmer(
  child: Card(
    child: ListTile(title: Text("Loading title")),
  ),
);
```

### HdrSkeletonShimmer
Outputs simple rectangular or circular colored block placeholders to build skeleton screen loading layouts.
```dart
// Rectangular skeleton block
HdrSkeletonShimmer(width: 140, height: 16),

// Circular skeleton block
HdrSkeletonShimmer.circular(size: 60),
```

---

## 🛠️ Utilities

### ValidatorUtils
Group of reusable text field validators with default English messages and custom error overrides.
```dart
// Validation checks
ValidatorUtils.validateFullName(name);
ValidatorUtils.validateEmailAddress(email, invalidError: "Invalid email syntax.");
ValidatorUtils.validatePhoneNumber(phone, 10, 10);
ValidatorUtils.validatePassword(password, isNewPasswordValidation: true);
ValidatorUtils.validateConfirmPassword(confirmPass, password);
```

### DialogUtils
Industry-standard alert, confirmation, and loader overlay modals built with rounded card styling and blurred backgrounds.
```dart
// 1. Show alert dialog
await DialogUtils.showAlert(
  context: context,
  title: "Welcome",
  message: "Alert information message.",
);

// 2. Show confirm dialog (returns Future<bool>)
bool confirmed = await DialogUtils.showConfirm(
  context: context,
  title: "Delete item?",
  message: "This action cannot be undone.",
);

// 3. Show loading spinner overlay (returns a dismissal callback)
final dismiss = DialogUtils.showLoading(context: context, message: "Uploading package...");
await Future.delayed(Duration(seconds: 3));
dismiss(); // Call to close modal
```

### ImagePickerUtils
Static wrappers around the device camera and gallery image picking actions.
```dart
XFile? galleryImage = await ImagePickerUtils.pickImageFromGallery();
XFile? cameraImage = await ImagePickerUtils.pickImageFromCamera();
```

### LoggerUtils
ANSI-colored log printer to debug console with optional path directory file storage.
```dart
// Print colored console logs
LoggerUtils.info("Info log message");
LoggerUtils.debug("Debug testing message");
LoggerUtils.success("Database sync successful!");
LoggerUtils.error("Network request failed.");

// Optional local file logger initialization (no-op on Web)
await LoggerUtils.init();
```

### RegExpUtils
Collection of matching regular expressions.
```dart
RegExpUtils.emailPatternRegExp
RegExpUtils.passwordPatternRegExp
RegExpUtils.numberRegExp
```

---

## ⚡ Extensions

### BuildContext Extensions
```dart
// Access MediaQuery dimensions
double screenWidth = context.width;
double screenHeight = context.height;

// Access Theme colors
ThemeData theme = context.theme;
ColorScheme colors = context.colorScheme;

// Keyboard manager
context.hideKeyboard();
```

### DateTime Extensions
```dart
// Formatting dates
String formatted = DateTime.now().toLocalString("yyyy-MM-dd");

// Time Ago labels
String timeAgo = DateTime.now().subtract(Duration(minutes: 5)).timeAgoLabel; // "5 min ago"
```

### List & Iterable Extensions
```dart
// Group items by key
Map<String, List<User>> grouped = users.groupBy((user) => user.role);

// Safe access
User? first = users.firstOrNull;
```

### Number & Double Extensions
```dart
// localized amount format
String currency = 12500.5.formattedAmount(); // "12,500.50"

// Compact Instagram notation
String followers = 1500000.compactFormat; // "1.5M"
```

### Color Extensions
```dart
// Quick opacity applications
Color shaded = Colors.blue.applyOpacity(0.5);
```

### String Extensions
```dart
// Check format suffixes
bool isSvg = "icon.svg".isSvg;
bool isImage = "image.png".isImage;

// Email masking
String obscured = "developer.harshit@example.com".obscureEmail(); // "dev*****************@example.com"

// Capitalization
String title = "flutter".capitalize; // "Flutter"
```

---

## 🐛 Features and Bugs

Please file feature requests and bugs at the [GitHub Issue Tracker](https://github.com/Harshit2027/hdr_utils/issues).

## 📧 Suggestions & Contributions

If you have any suggestions, feature ideas, or feedback, feel free to reach out via email:
👉 **[harshitrajput396450@gmail.com](mailto:harshitrajput396450@gmail.com)**

---

## ⭐ If you like the package, a star to the repository will mean a lot.

## Thank you ❤️
