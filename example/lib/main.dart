import 'package:flutter/material.dart';
import 'package:hdr_utils/hdr_utils.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: Uncomment to enable saving logs to local files.
  // If enabled, logs will be stored in the device's application documents directory.
  // await LoggerUtils.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDR Utils Showcase',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ShowcaseDashboard(),
    );
  }
}

class ShowcaseDashboard extends StatefulWidget {
  const ShowcaseDashboard({super.key});

  @override
  State<ShowcaseDashboard> createState() => _ShowcaseDashboardState();
}

class _ShowcaseDashboardState extends State<ShowcaseDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers for Form Validation section
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // Selected local image
  XFile? _selectedImage;

  // Fake loading state for Shimmer demonstration
  bool _isShimmerLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    LoggerUtils.success("Showcase dashboard initialized.");
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡ HDR Utils Dashboard'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(
              icon: Icon(Icons.check_circle_outline),
              text: "Widgets & Validators",
            ),
            Tab(icon: Icon(Icons.chat_bubble_outline), text: "Dialogs"),
            Tab(icon: Icon(Icons.image_outlined), text: "Image Picker"),
            Tab(icon: Icon(Icons.blur_linear), text: "Shimmers"),
            Tab(icon: Icon(Icons.extension_outlined), text: "Extensions"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildValidatorsTab(),
          _buildDialogsTab(),
          _buildImagePickerTab(),
          _buildShimmersTab(),
          _buildExtensionsTab(),
        ],
      ),
    );
  }

  // --- VALIDATORS TAB ---
  Widget _buildValidatorsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              "HdrTextField & ValidatorUtils",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "HdrTextField handles validation state rendering, formatting and taps-outside keyboard unfocus.",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            HdrTextField(
              controller: _nameController,
              labelText: "Full Name",
              hintText: "Enter full name",
              prefixIcon: const Icon(Icons.person_outline),
              validator: (val) => ValidatorUtils.validateFullName(val),
            ),
            const SizedBox(height: 16),
            HdrTextField(
              controller: _emailController,
              labelText: "Email Address",
              hintText: "example@domain.com",
              prefixIcon: const Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              validator: (val) => ValidatorUtils.validateEmailAddress(val),
            ),
            const SizedBox(height: 16),
            HdrTextField(
              controller: _phoneController,
              labelText: "Phone Number",
              hintText: "10-digit mobile number",
              prefixIcon: const Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
              validator: (val) =>
                  ValidatorUtils.validatePhoneNumber(val, 10, 10),
            ),
            const SizedBox(height: 16),
            HdrTextField(
              controller: _passwordController,
              labelText: "Password",
              hintText: "Min 8 characters, digit, special, case check",
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: true,
              validator: (val) => ValidatorUtils.validatePassword(
                val,
                isNewPasswordValidation: true,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoggerUtils.success("Form validated successfully!");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form Validated Successfully!'),
                      ),
                    );
                  } else {
                    LoggerUtils.error("Form validation failed.");
                  }
                },
                child: const Text(
                  "Submit Form",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- DIALOGS TAB ---
  Widget _buildDialogsTab() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              size: 72,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            Text(
              "DialogUtils Utilities",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Trigger custom styled dialog overlays using static calls from DialogUtils.",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            _buildDialogButton(
              label: "Show Alert Dialog",
              icon: Icons.info_outline,
              onPressed: () async {
                await DialogUtils.showAlert(
                  context: context,
                  title: "Alert Notification",
                  message: "This is a clean, modern alert message.",
                );
              },
            ),
            const SizedBox(height: 16),
            _buildDialogButton(
              label: "Show Confirm Dialog",
              icon: Icons.help_outline,
              onPressed: () async {
                final result = await DialogUtils.showConfirm(
                  context: context,
                  title: "Confirm Action",
                  message: "Do you want to confirm this package configuration?",
                  confirmButtonText: "Confirm",
                  cancelButtonText: "Cancel",
                );
                LoggerUtils.info("Confirm result: $result");
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Confirm resolved to: $result')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            _buildDialogButton(
              label: "Show Loading Dialog",
              icon: Icons.hourglass_empty,
              onPressed: () async {
                final dismiss = DialogUtils.showLoading(
                  context: context,
                  message: "Syncing project configuration...",
                );
                await Future.delayed(const Duration(seconds: 3));
                dismiss();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  // --- IMAGE PICKER TAB ---
  Widget _buildImagePickerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "ImagePickerUtils & HdrImagePickerBuilder",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Use ImagePickerUtils static helpers to pick images, and HdrImagePickerBuilder to render them.",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: HdrImagePickerBuilder(
              localImage: _selectedImage,
              imageUrl: _selectedImage == null
                  ? "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=500&auto=format&fit=crop"
                  : null,
              width: 200,
              height: 200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              placeholderBuilder: (context) => Container(
                color: context.colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.image, size: 64),
              ),
              onTap: () async {
                final confirm = await DialogUtils.showConfirm(
                  context: context,
                  title: "Photo Source",
                  message: "Where would you like to select your photo?",
                  confirmButtonText: "Gallery",
                  cancelButtonText: "Camera",
                );

                XFile? pickedFile;
                if (confirm) {
                  pickedFile = await ImagePickerUtils.pickImageFromGallery();
                } else {
                  pickedFile = await ImagePickerUtils.pickImageFromCamera();
                }

                if (pickedFile != null) {
                  LoggerUtils.success("Selected: ${pickedFile.name}");
                  setState(() {
                    _selectedImage = pickedFile;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Tap image to pick new photo",
            style: context.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          if (_selectedImage != null) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              icon: const Icon(Icons.clear),
              label: const Text("Reset Image"),
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  // --- SHIMMERS TAB ---
  Widget _buildShimmersTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HdrSkeletonShimmer Skeleton Loaders",
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Toggle switch to load mock data",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
                value: !_isShimmerLoading,
                onChanged: (val) {
                  setState(() {
                    _isShimmerLoading = !val;
                  });
                },
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _isShimmerLoading
                    ? _buildShimmerItem()
                    : _buildLoadedItem(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerItem() {
    return Row(
      children: [
        const HdrSkeletonShimmer.circular(size: 60),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HdrSkeletonShimmer(height: 16, width: 140),
              const SizedBox(height: 8),
              const HdrSkeletonShimmer(height: 12, width: double.infinity),
              const SizedBox(height: 4),
              const HdrSkeletonShimmer(height: 12, width: 200),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedItem(int index) {
    return Card(
      elevation: 0,
      color: context.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.primaryContainer,
          child: Text("${index + 1}"),
        ),
        title: Text(
          "Loaded Post Title ${index + 1}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "Loaded content description after asynchronous skeleton shimmer delay.",
        ),
      ),
    );
  }

  // --- EXTENSIONS TAB ---
  Widget _buildExtensionsTab() {
    final double testValue = 1250000.75;
    final now = DateTime.now();
    final fiveMinAgo = DateTime.now().subtract(const Duration(minutes: 5));
    final String emailToObscure = "developer.harshit@example.com";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Core Extensions Showroom",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildExtensionSection(
            title: "NumberExtensions",
            items: [
              "Raw value: $testValue",
              "Formatted Amount: \$${testValue.formattedAmount()}",
              "Compact Format: ${testValue.compactFormat}",
              "Decimal Trimming (5.50): ${5.50.decimalFormatAmount}",
            ],
          ),
          const SizedBox(height: 16),
          _buildExtensionSection(
            title: "DateTimeExtensions",
            items: [
              "Current DateTime: $now",
              "toLocalString: ${now.toLocalString('EEE, d MMM yyyy')}",
              "toUtcString: ${now.toUtcString()}",
              "Is Today: ${now.isToday}",
              "Time Ago (5 mins back): ${fiveMinAgo.timeAgoLabel}",
            ],
          ),
          const SizedBox(height: 16),
          _buildExtensionSection(
            title: "StringExtensions",
            items: [
              "Raw Email: $emailToObscure",
              "Obscured Email: ${emailToObscure.obscureEmail()}",
              "Capitalized 'flutter': ${'flutter'.capitalize}",
              "Check isSvg ('icon.svg'): ${'icon.svg'.isSvg}",
              "Check isImage ('test.png'): ${'test.png'.isImage}",
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "LoggerUtils Console Triggers",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text("Click to output colored logs to debug terminal:"),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => LoggerUtils.info("Info level log message"),
                child: const Text("Info Log"),
              ),
              ElevatedButton(
                onPressed: () =>
                    LoggerUtils.success("Success level log message"),
                child: const Text("Success Log"),
              ),
              ElevatedButton(
                onPressed: () => LoggerUtils.error("Error level log message"),
                child: const Text("Error Log"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtensionSection({
    required String title,
    required List<String> items,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: context.colorScheme.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            const Divider(),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
