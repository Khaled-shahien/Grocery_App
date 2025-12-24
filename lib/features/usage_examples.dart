// import 'package:flutter/material.dart';
// import 'package:grocery_app/core/widgets/custom_snackbar.dart';

// class SnackBarTestPage extends StatefulWidget {
//   const SnackBarTestPage({super.key});

//   @override
//   State<SnackBarTestPage> createState() => _SnackBarTestPageState();
// }

// class _SnackBarTestPageState extends State<SnackBarTestPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isPasswordVisible = false;
//   final _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.purple.shade50,
//               Colors.blue.shade50,
//               Colors.pink.shade50,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               _buildHeader(),
//               _buildTabBar(),
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildStatusTestsTab(),
//                     _buildActionsTab(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.purple.withOpacity(0.3),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.notifications_active_rounded,
//               size: 40,
//               color: Colors.purple.shade600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'SnackBar Testing Lab',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//               letterSpacing: 0.5,
//             ),
//           ),
//           Text(
//             'اختبر جميع أنواع الإشعارات',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(50),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.purple.shade400, Colors.blue.shade400],
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.grey.shade600,
//         labelStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//         indicatorSize: TabBarIndicatorSize.tab,
//         dividerColor: Colors.transparent,
//         tabs: const [
//           Tab(
//             icon: Icon(Icons.flag_rounded),
//             text: 'الحالات',
//           ),
//           Tab(
//             icon: Icon(Icons.touch_app_rounded),
//             text: 'الإجراءات',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusTestsTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           _buildStatusCard(
//             icon: Icons.check_circle_rounded,
//             title: 'نجاح',
//             subtitle: 'تم بنجاح',
//             gradient: [Colors.green.shade400, Colors.green.shade600],
//             onTap: () {
//               CustomSnackBar.showSuccess(
//                 context: context,
//                 title: 'تم بنجاح! ✨',
//                 message: 'تمت العملية بنجاح وتم حفظ جميع التغييرات.',
//               );
//             },
//           ),
//           _buildStatusCard(
//             icon: Icons.lightbulb_rounded,
//             title: 'معلومة',
//             subtitle: 'رسالة معلوماتية',
//             gradient: [Colors.blue.shade400, Colors.blue.shade600],
//             onTap: () {
//               CustomSnackBar.showInfo(
//                 context: context,
//                 title: 'معلومة مفيدة 💡',
//                 message: 'هل تعلم؟ يمكنك حفظ المنتجات المفضلة لديك.',
//               );
//             },
//           ),
//           _buildStatusCard(
//             icon: Icons.warning_rounded,
//             title: 'تحذير',
//             subtitle: 'انتبه لهذا',
//             gradient: [Colors.orange.shade400, Colors.orange.shade600],
//             onTap: () {
//               CustomSnackBar.showWarning(
//                 context: context,
//                 title: 'تحذير! ⚠️',
//                 message: 'السلة الخاصة بك تحتوي على منتجات منتهية الصلاحية.',
//               );
//             },
//           ),
//           _buildStatusCard(
//             icon: Icons.cancel_rounded,
//             title: 'خطأ',
//             subtitle: 'حدث خطأ',
//             gradient: [Colors.red.shade400, Colors.red.shade600],
//             onTap: () {
//               CustomSnackBar.showError(
//                 context: context,
//                 title: 'فشلت العملية! ❌',
//                 message: 'عذراً، حدث خطأ أثناء معالجة طلبك. حاول مرة أخرى.',
//               );
//             },
//           ),
//           _buildStatusCard(
//             icon: Icons.shopping_cart_rounded,
//             title: 'السلة',
//             subtitle: 'إضافة للسلة',
//             gradient: [Colors.purple.shade400, Colors.purple.shade600],
//             onTap: () {
//               CustomSnackBar.showCart(
//                 context: context,
//                 title: 'تمت الإضافة! 🛒',
//                 message: 'تم إضافة المنتج إلى سلة التسوق بنجاح.',
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionsTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           _buildActionScenario(
//             icon: Icons.login_rounded,
//             title: 'تسجيل الدخول',
//             description: 'اختبر نجاح أو فشل تسجيل الدخول',
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'البريد الإلكتروني',
//                   prefixIcon: const Icon(Icons.email_rounded),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: !_isPasswordVisible,
//                 decoration: InputDecoration(
//                   labelText: 'كلمة المرور',
//                   prefixIcon: const Icon(Icons.lock_rounded),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility_rounded
//                           : Icons.visibility_off_rounded,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isPasswordVisible = !_isPasswordVisible;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildActionButton(
//                       label: 'دخول ناجح',
//                       icon: Icons.check_circle_outline_rounded,
//                       gradient: [Colors.green.shade400, Colors.green.shade600],
//                       onPressed: () {
//                         CustomSnackBar.showSuccess(
//                           context: context,
//                           title: 'مرحباً بك! 👋',
//                           message: 'تم تسجيل الدخول بنجاح. استمتع بالتسوق!',
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: _buildActionButton(
//                       label: 'دخول فاشل',
//                       icon: Icons.error_outline_rounded,
//                       gradient: [Colors.red.shade400, Colors.red.shade600],
//                       onPressed: () {
//                         CustomSnackBar.showError(
//                           context: context,
//                           title: 'فشل تسجيل الدخول ❌',
//                           message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           _buildActionScenario(
//             icon: Icons.shopping_bag_rounded,
//             title: 'إدارة المنتجات',
//             description: 'اختبر عمليات المنتجات المختلفة',
//             children: [
//               _buildProductCard(
//                 name: 'تفاح أحمر طازج',
//                 price: '25 جنيه',
//                 image: Icons.apple_rounded,
//               ),
//               const SizedBox(height: 12),
//               _buildProductCard(
//                 name: 'موز عضوي',
//                 price: '18 جنيه',
//                 image: Icons.food_bank_rounded,
//               ),
//             ],
//           ),
//           _buildActionScenario(
//             icon: Icons.password_rounded,
//             title: 'تغيير كلمة المرور',
//             description: 'اختبر نجاح أو فشل تغيير كلمة المرور',
//             children: [
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'كلمة المرور الحالية',
//                   prefixIcon: const Icon(Icons.lock_outline_rounded),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'كلمة المرور الجديدة',
//                   prefixIcon: const Icon(Icons.lock_rounded),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildActionButton(
//                       label: 'تغيير ناجح',
//                       icon: Icons.check_circle_outline_rounded,
//                       gradient: [Colors.green.shade400, Colors.green.shade600],
//                       onPressed: () {
//                         CustomSnackBar.showSuccess(
//                           context: context,
//                           title: 'تم التحديث! 🔐',
//                           message: 'تم تغيير كلمة المرور بنجاح.',
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: _buildActionButton(
//                       label: 'تغيير فاشل',
//                       icon: Icons.error_outline_rounded,
//                       gradient: [Colors.red.shade400, Colors.red.shade600],
//                       onPressed: () {
//                         CustomSnackBar.showError(
//                           context: context,
//                           title: 'فشل التحديث ❌',
//                           message: 'كلمة المرور الحالية غير صحيحة.',
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required List<Color> gradient,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: gradient[0].withOpacity(0.3),
//                   blurRadius: 15,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: gradient),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey.shade800,
//                         ),
//                       ),
//                       Text(
//                         subtitle,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: Colors.grey.shade400,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActionScenario({
//     required IconData icon,
//     required String title,
//     required String description,
//     required List<Widget> children,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 24),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.purple.shade400, Colors.blue.shade400],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade800,
//                       ),
//                     ),
//                     Text(
//                       description,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton({
//     required String label,
//     required IconData icon,
//     required List<Color> gradient,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: gradient),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: gradient[0].withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: Colors.white, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard({
//     required String name,
//     required String price,
//     required IconData image,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.orange.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               image,
//               color: Colors.orange.shade600,
//               size: 32,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade800,
//                   ),
//                 ),
//                 Text(
//                   price,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.orange.shade600,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.purple.shade400, Colors.purple.shade600],
//               ),
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.purple.shade300.withOpacity(0.5),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   CustomSnackBar.showCart(
//                     context: context,
//                     title: 'تمت الإضافة! 🛒',
//                     message: 'تم إضافة $name إلى سلة التسوق.',
//                   );
//                 },
//                 borderRadius: BorderRadius.circular(10),
//                 child: const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Icon(
//                     Icons.add_shopping_cart_rounded,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:grocery_app/core/widgets/custom_loading_dialog.dart';
// import 'package:grocery_app/core/widgets/custom_snackbar.dart';

// class LoadingDialogUsageExamples extends StatefulWidget {
//   const LoadingDialogUsageExamples({super.key});

//   @override
//   State<LoadingDialogUsageExamples> createState() =>
//       _LoadingDialogUsageExamplesState();
// }

// class _LoadingDialogUsageExamplesState
//     extends State<LoadingDialogUsageExamples> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }

//   Future<void> _simulateLogin({required bool success}) async {
//     // Show loading dialog
//     CustomLoadingDialog.showLogin(context);

//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 3));

//     // Hide loading dialog
//     if (mounted) {
//       CustomLoadingDialog.hide(context);

//       // Show result
//       if (success) {
//         CustomSnackBar.showSuccess(
//           context: context,
//           title: 'مرحباً بك! 👋',
//           message: 'تم تسجيل الدخول بنجاح. استمتع بالتسوق!',
//         );
//       } else {
//         CustomSnackBar.showError(
//           context: context,
//           title: 'فشل تسجيل الدخول ❌',
//           message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
//         );
//       }
//     }
//   }

//   Future<void> _simulateRegister({required bool success}) async {
//     CustomLoadingDialog.showRegister(context);
//     await Future.delayed(const Duration(seconds: 3));

//     if (mounted) {
//       CustomLoadingDialog.hide(context);

//       if (success) {
//         CustomSnackBar.showSuccess(
//           context: context,
//           title: 'تم إنشاء الحساب! 🎉',
//           message: 'مرحباً بك في تطبيقنا. يمكنك البدء الآن!',
//         );
//       } else {
//         CustomSnackBar.showError(
//           context: context,
//           title: 'فشل إنشاء الحساب ❌',
//           message: 'هذا البريد الإلكتروني مستخدم بالفعل.',
//         );
//       }
//     }
//   }

//   Future<void> _simulateProcessing(LoadingType type) async {
//     switch (type) {
//       case LoadingType.processing:
//         CustomLoadingDialog.showProcessing(context);
//         break;
//       case LoadingType.uploading:
//         CustomLoadingDialog.showUploading(context);
//         break;
//       case LoadingType.downloading:
//         CustomLoadingDialog.showDownloading(context);
//         break;
//       default:
//         CustomLoadingDialog.show(
//           context: context,
//           title: 'جاري التحميل',
//           message: 'يرجى الانتظار...',
//           type: type,
//         );
//     }

//     await Future.delayed(const Duration(seconds: 2));

//     if (mounted) {
//       CustomLoadingDialog.hide(context);
//       CustomSnackBar.showSuccess(
//         context: context,
//         title: 'تمت العملية بنجاح! ✓',
//         message: 'تم إتمام العملية المطلوبة.',
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               const Color(0xFF6C5CE7).withOpacity(0.1),
//               const Color(0xFF00B894).withOpacity(0.1),
//               const Color(0xFFFDCB6E).withOpacity(0.1),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(height: 30),
//                 _buildLoginSection(),
//                 const SizedBox(height: 24),
//                 _buildRegisterSection(),
//                 const SizedBox(height: 24),
//                 _buildQuickActionsSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFF6C5CE7),
//             Color(0xFFA29BFE),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF6C5CE7).withOpacity(0.4),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.science_rounded,
//               size: 40,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Loading Dialog Lab',
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               letterSpacing: 0.5,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'اختبر جميع أنواع dialogs المخصصة',
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.white.withOpacity(0.9),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginSection() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.login_rounded,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'تسجيل الدخول',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(
//               labelText: 'البريد الإلكتروني',
//               hintText: 'example@email.com',
//               prefixIcon: const Icon(Icons.email_rounded),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _passwordController,
//             obscureText: !_isPasswordVisible,
//             decoration: InputDecoration(
//               labelText: 'كلمة المرور',
//               hintText: '••••••••',
//               prefixIcon: const Icon(Icons.lock_rounded),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   _isPasswordVisible
//                       ? Icons.visibility_rounded
//                       : Icons.visibility_off_rounded,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isPasswordVisible = !_isPasswordVisible;
//                   });
//                 },
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildGradientButton(
//                   label: 'دخول ناجح',
//                   icon: Icons.check_circle_rounded,
//                   gradient: const [Color(0xFF00B894), Color(0xFF55EFC4)],
//                   onPressed: () => _simulateLogin(success: true),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _buildGradientButton(
//                   label: 'دخول فاشل',
//                   icon: Icons.error_rounded,
//                   gradient: const [Color(0xFFFF7675), Color(0xFFFF6B9D)],
//                   onPressed: () => _simulateLogin(success: false),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRegisterSection() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF00B894), Color(0xFF55EFC4)],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.person_add_rounded,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'إنشاء حساب جديد',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _nameController,
//             decoration: InputDecoration(
//               labelText: 'الاسم الكامل',
//               hintText: 'أدخل اسمك',
//               prefixIcon: const Icon(Icons.person_rounded),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'البريد الإلكتروني',
//               hintText: 'example@email.com',
//               prefixIcon: const Icon(Icons.email_rounded),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: 'كلمة المرور',
//               hintText: '••••••••',
//               prefixIcon: const Icon(Icons.lock_rounded),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildGradientButton(
//                   label: 'إنشاء ناجح',
//                   icon: Icons.check_circle_rounded,
//                   gradient: const [Color(0xFF00B894), Color(0xFF55EFC4)],
//                   onPressed: () => _simulateRegister(success: true),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _buildGradientButton(
//                   label: 'إنشاء فاشل',
//                   icon: Icons.error_rounded,
//                   gradient: const [Color(0xFFFF7675), Color(0xFFFF6B9D)],
//                   onPressed: () => _simulateRegister(success: false),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickActionsSection() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFFFDCB6E), Color(0xFFFFE66D)],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.flash_on_rounded,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'إجراءات سريعة',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _buildQuickActionCard(
//             title: 'معالجة البيانات',
//             subtitle: 'اختبر dialog المعالجة',
//             icon: Icons.settings_rounded,
//             gradient: const [Color(0xFFFD79A8), Color(0xFFFAB1A0)],
//             onTap: () => _simulateProcessing(LoadingType.processing),
//           ),
//           const SizedBox(height: 12),
//           _buildQuickActionCard(
//             title: 'رفع الملفات',
//             subtitle: 'اختبر dialog الرفع',
//             icon: Icons.cloud_upload_rounded,
//             gradient: const [Color(0xFFFDCB6E), Color(0xFFFFE66D)],
//             onTap: () => _simulateProcessing(LoadingType.uploading),
//           ),
//           const SizedBox(height: 12),
//           _buildQuickActionCard(
//             title: 'تحميل البيانات',
//             subtitle: 'اختبر dialog التحميل',
//             icon: Icons.cloud_download_rounded,
//             gradient: const [Color(0xFF74B9FF), Color(0xFFDFE6E9)],
//             onTap: () => _simulateProcessing(LoadingType.downloading),
//           ),
//           const SizedBox(height: 12),
//           _buildQuickActionCard(
//             title: 'تحميل عام',
//             subtitle: 'اختبر dialog التحميل العام',
//             icon: Icons.hourglass_empty_rounded,
//             gradient: const [Color(0xFF0984E3), Color(0xFF74B9FF)],
//             onTap: () => _simulateProcessing(LoadingType.loading),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickActionCard({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required List<Color> gradient,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: gradient),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: gradient[0].withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: Colors.grey.shade400,
//                 size: 18,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGradientButton({
//     required String label,
//     required IconData icon,
//     required List<Color> gradient,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: gradient),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: gradient[0].withOpacity(0.4),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: Colors.white, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }