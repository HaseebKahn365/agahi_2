import 'package:flutter/material.dart';

class AgricultureListView extends StatelessWidget {
  const AgricultureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add your agriculture list items here
        // show agri1 agri2 agri3 images
        displayImageButton('assets/images/agri_care.png', context),
        const SizedBox(height: 20),
        displayImageButton('assets/images/leave_dis.jpg', context),
        const SizedBox(height: 20),
        displayImageButton('assets/images/seed_stor.jpg', context),
      ],
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imagePath == 'assets/images/agri_care.png') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgriSubjectScreenForCare()),
          );
          // Implement your navigation logic here
        }

        if (imagePath == 'assets/images/leave_dis.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgriSubjectScreenForLeavesDiseases(),
            ),
          );
          // Implement your navigation logic here
        }
        if (imagePath == 'assets/images/seed_stor.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgriSubjectScreenForSeedStorage(),
            ),
          );
          // Implement your navigation logic here
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

//display agri_care in a simple single child scroll view images ie. agri_care1, agri_care2, agri_care3

class AgriSubjectScreenForCare extends StatelessWidget {
  const AgriSubjectScreenForCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                displayImageButton('assets/images/agri_care1.jpg', context),
                const SizedBox(height: 20),
                displayImageButton('assets/images/agri_care2.jpg', context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

//display agri_care in a simple single child scroll view images ie. agri_care1, agri_care2, agri_care3

class AgriSubjectScreenForLeavesDiseases extends StatelessWidget {
  const AgriSubjectScreenForLeavesDiseases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                displayImageButton('assets/images/leave_dis1.jpg', context),
                const SizedBox(height: 20),
                displayImageButton('assets/images/leave_dis2.jpg', context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

//display agri_care in a simple single child scroll view images ie. agri_care1, agri_care2, agri_care3

class AgriSubjectScreenForSeedStorage extends StatelessWidget {
  const AgriSubjectScreenForSeedStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                displayImageButton('assets/images/seed_stor1.jpg', context),
                const SizedBox(height: 20),
                displayImageButton('assets/images/seed_stor2.jpg', context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AgriSubjectScreenForSeedStorage(),
        //   ),
        // );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
