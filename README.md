# 🛠️ HDR Utils

A modern, highly-polished package containing essential UI widgets, extensions, validators, and logger utilities for Flutter developers. Optimized for visual excellence, distinct naming, and developer ergonomics.

## 🚀 Features

- **📝 Widgets**: Distinctly prefixed with `Hdr` to identify they are package components.
  - `HdrTextField`: A beautiful Material 3 text field with built-in auto-validation, border animations, and automatic unfocus on tapping outside.
  - `HdrImagePickerBuilder`: Displays local files (`XFile` bytes) or cached network images with clip behaviors and optional shapes.
  - `HdrCustomShimmer` & `HdrSkeletonShimmer`: Premium skeleton loaders to build loading states.
- **🛡️ Utilities**: Grouped into static helper classes to avoid naming conflicts.
  - `ValidatorUtils`: Reusable logic for Full Name, Email, Password, Phone, and OTP validators with custom localized messages support.
  - `DialogUtils`: Standard alerts, confirmations (yes/no), and loading dialog block overlays with blurred backdrop filter backgrounds.
  - `ImagePickerUtils`: Helpers to pick images from camera or gallery.
  - `LoggerUtils`: Fully safe developer logger with ANSI colored console output and file logs persistence.
  - `RegExpUtils`: Regular expressions for email, phone, name, space, amount, bank account, and IFSC codes.
- **🧩 Extensions**: Helpful extensions on core types:
  - `ContextExtensions`: Easy access to dimensions, themes, padding, and soft keyboard dismissal.
  - `DateTimeExtensions`: Time-ago formatting, checking today status, and UTC/local string conversions.
  - `ListExtensions` & `IterableExtensions`: Null-safe helpers, index mapping, and asynchronous iterations.
  - `NumberExtensions`: Instagram-style compact formatting (K, M, B) and localized currency amounts.
  - `ColorExtensions`: Subtle transparency filters.
  - `StringExtensions`: Birth-date age calculation, UTC/local date parsing, SVG/Image/Video format validations, and email obscuring.

---

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  hdr_utils: ^0.0.1
```

And run:
```bash
flutter pub get
```

---

## 💡 Usage Examples

### 1. Form Validation with `HdrTextField`

Combine `HdrTextField` and `ValidatorUtils` to build forms:

```dart
HdrTextField(
  controller: emailController,
  labelText: "Email Address",
  hintText: "Enter your email",
  keyboardType: TextInputType.emailAddress,
  validator: (val) => ValidatorUtils.validateEmailAddress(val, invalidError: "Incorrect email format."),
);
```

### 2. Standard Dialogs with `DialogUtils`

Show beautiful, blurred alerts or block interaction during network requests using the loading modal:

```dart
// 1. Show alert dialog
await DialogUtils.showAlert(
  context: context,
  title: "Welcome",
  message: "Thank you for using HDR Utils!",
);

// 2. Show loading spinner and dismiss it when done
final dismissLoader = DialogUtils.showLoading(context: context, message: "Syncing data...");
await Future.delayed(Duration(seconds: 2));
dismissLoader();
```

### 3. Image Picking and Rendering

Pick an image and render it using `HdrImagePickerBuilder`:

```dart
XFile? selectedImage;

void pickImage() async {
  final image = await ImagePickerUtils.pickImageFromGallery();
  if (image != null) {
    setState(() {
      selectedImage = image;
    });
  }
}

// In build():
HdrImagePickerBuilder(
  localImage: selectedImage,
  imageUrl: null,
  placeholderBuilder: (context) => Icon(Icons.person, size: 50),
  shape: CircleBorder(),
  onTap: pickImage,
  width: 100,
  height: 100,
)
```

### 4. Skeleton Loading (Shimmers)

Easily build list loading states with skeleton blocks:

```dart
ListView.builder(
  itemCount: 3,
  itemBuilder: (context, index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        HdrSkeletonShimmer.circular(size: 50),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HdrSkeletonShimmer(width: 120, height: 16),
            SizedBox(height: 8),
            HdrSkeletonShimmer(width: 80, height: 12),
          ],
        )
      ],
    ),
  ),
);
```

### 5. Color Logger

```dart
LoggerUtils.info("Info log message");
LoggerUtils.debug("Debug testing message");
LoggerUtils.success("Database connected successfully");
LoggerUtils.error("Failed to fetch API endpoint");
```

> [!NOTE]
> Console logging works out-of-the-box. To optionally persist log files to the device's storage (Application Documents directory), initialize the logger in your `main()` method:
> ```dart
> void main() async {
>   WidgetsFlutterBinding.ensureInitialized();
>   await LoggerUtils.init(); // Optional: enables local file logging
>   runApp(const MyApp());
> }
> ```

---

## 🛠 Maintainers

Built and maintained by [Harshit Rajput](https://github.com/Harshit2027)
