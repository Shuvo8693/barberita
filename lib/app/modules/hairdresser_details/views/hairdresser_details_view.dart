import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/widgets/custom_button.dart';

class HairdresserDetailsView extends StatefulWidget {
  const HairdresserDetailsView({super.key});

  @override
  State<HairdresserDetailsView> createState() => _HairdresserDetailsViewState();
}

class _HairdresserDetailsViewState extends State<HairdresserDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Column(
        children: [
          // Hero Image Section
          Stack(
            children: [
              Container(
                height: 300.h,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/barbershop.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient Overlay
              Container(
                height: 300.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Back Button
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Rating Badge
              Positioned(
                bottom: 16.h,
                right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '4.5',
                        style: GoogleFontStyles.h6(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tab Bar
          Container(
            color: const Color(0xFF1C1C1E),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFE6C4A3),
              indicatorWeight: 2,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.6),
              labelStyle: GoogleFontStyles.h5(fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFontStyles.h5(fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: 'About'),
                Tab(text: 'Reviews'),
                Tab(text: 'Services'),
              ],
            ),
          ),

          // Tab Bar View Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildReviewsTab(),
                _buildServicesTab(),
              ],
            ),
          ),

          // Book Appointment Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: CustomButton(
              onTap: () {
                // Handle booking
              },
              text: 'Book Appointment',
              textStyle: GoogleFontStyles.h4(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              color: const Color(0xFFE6C4A3),
              borderRadius: 12.r,
              height: 56.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hairdresser Name
          Text(
            'Hairdresser: John Doew',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),

          // Working Hours
          Text(
            'Working Hour: 9AM - 9PM',
            style: GoogleFontStyles.h5(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),

          // Experience
          Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: const Color(0xFFE6C4A3),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Experience 3 Years',
                style: GoogleFontStyles.h5(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Description
          Text(
            'John Doe is a professional hairdresser, known for his skilled haircuts and grooming services. With years of experience in the industry, he specializes in both traditional and modern styles, offering a wide range of services to meet your hairdressing and grooming needs.\n\nJohn, John is passionate about creating personalized, high-quality services through creative and meticulous styling, leaving you feeling fresh and confident. His attention to detail and friendly manner make him a trusted choice for those looking for a top-tier barbering experience...... ',
            style: GoogleFontStyles.h5(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          SizedBox(height: 16.h),

          // See More Button
          GestureDetector(
            onTap: () {},
            child: Text(
              'See More',
              style: GoogleFontStyles.h5(
                color: const Color(0xFFE6C4A3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Text(
            'Review (1208)',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),

          // Review Items
          _buildReviewItem(
            'John Perkins',
            '4.5',
            '1 days ago',
            'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.',
            'assets/images/user1.jpg',
          ),
          SizedBox(height: 20.h),

          _buildReviewItem(
            'John Perkins',
            '4.2',
            '1 days ago',
            'The barbers are highly skilled, offering everything from sharp, contemporary cuts to classic styles. The atmosphere is welcoming, with a nostalgic old-school vibe that makes it feel like you\'ve stepped into a time capsule of barbering excellence.',
            'assets/images/user2.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, String rating, String time, String review, String avatar) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(avatar),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: GoogleFontStyles.h6(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Review Text
          Text(
            review,
            style: GoogleFontStyles.h6(
              color: Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Services Header
          Text(
            'Our Services',
            style: GoogleFontStyles.h4(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),

          // Service Items
          _buildServiceItem(
            'Basic Hair cut',
            'A simple yet servicelook.',
            '\$50',
            'assets/images/service1.jpg',
          ),
          SizedBox(height: 16.h),

          _buildServiceItem(
            'Child Hair cut',
            'A simple yet servicelook.',
            '\$50',
            'assets/images/service2.jpg',
          ),
          SizedBox(height: 16.h),

          _buildServiceItem(
            'Hair Trim',
            'A simple yet servicelook.',
            '\$50',
            'assets/images/service3.jpg',
          ),
          SizedBox(height: 16.h),

          _buildServiceItem(
            'Basic Hair cut',
            'A simple yet servicelook.',
            '\$50',
            'assets/images/service4.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String subtitle, String price, String image) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Checkbox
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 16.w),

          // Service Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              image,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),

          // Service Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Price
          Text(
            price,
            style: GoogleFontStyles.h5(
              color: const Color(0xFFE6C4A3),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}