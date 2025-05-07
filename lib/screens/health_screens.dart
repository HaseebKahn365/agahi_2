import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeverScreen extends StatelessWidget {
  const FeverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: const EdgeInsets.all(20),
              icon: Image.asset(
                'assets/images/back.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://www.best-home-remedies.com/wp-content/uploads/2018/04/fever.jpg',
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Symptoms:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Elevated body temperature\n• Chills and shivering\n• Headache\n• Muscle aches\n• Loss of appetite\n• Dehydration\n• General weakness',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Treatment:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://th.bing.com/th/id/OIP.zuR_wE_RL-K9WSrhFnQz0QHaE8?cb=iwp1&w=800&h=534&rs=1&pid=ImgDetMain',
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Rest and drink plenty of fluids\n• Take over-the-counter fever reducers\n• Use cool compresses\n• Wear lightweight clothing\n• Take lukewarm baths',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medications:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://derma.pk/wp-content/uploads/2024/01/PANADOL-TABLETS-PARACETAMOL-PACK-OF-200-TABLETS.webp',
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Paracetamol (Acetaminophen)\n• Ibuprofen\n• Aspirin (for adults only)\n• Naproxen\n• Panadol (Paracetamol)',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class BellyPainScreen extends StatelessWidget {
  const BellyPainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: const EdgeInsets.all(20),
              icon: Image.asset(
                'assets/images/back.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKHkeeQ_ViPsCZMBqHWh3q7YOfQBy22YBPiA&s',
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Symptoms:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Abdominal discomfort or cramping\n• Bloating\n• Gas\n• Nausea\n• Changes in bowel movements\n• Loss of appetite',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Treatment:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Drink plenty of fluids\n• Apply heat to the abdomen\n• Try over-the-counter antacids\n• Eat bland foods\n• Avoid fatty or spicy foods\n• Get adequate rest',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medications:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Antacids (Tums, Rolaids)\n• H2 blockers (Pepcid, Zantac)\n• Proton pump inhibitors (Prilosec)\n• Simethicone (Gas-X)\n• Loperamide (Imodium) for diarrhea',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,

          children: [
            IconButton(
              padding: const EdgeInsets.all(20),
              icon: Image.asset(
                'assets/images/back.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            _buildDoctorCard(
              name: 'Dr. Arif Alvi',
              specialty: 'General Physician (MBBS, FCPS)',
              // Replace with actual image URLs
              imageUrl:
                  'https://burjeel.com/burjeelmedicalcity/wp-content/uploads/sites/14/2022/10/Dr.-Faraz-Khalid.png',
              address: 'Clifton Medical Services, Block 5 Clifton, Karachi',
            ),
            const SizedBox(height: 16),
            _buildDoctorCard(
              name: 'Dr. Ahmed Raza Khan',
              specialty: 'Cardiologist (MBBS, Dip. Card, FCPS Cardiology)',
              // Replace with actual image URLs
              imageUrl:
                  'https://static.vecteezy.com/system/resources/previews/046/680/023/non_2x/an-old-pakistani-male-doctor-on-isolated-transparent-background-png.png',
              address: 'Punjab Institute of Cardiology, Jail Road, Lahore',
            ),
            const SizedBox(height: 16),
            _buildDoctorCard(
              name: 'Dr. Ayesha Malik',
              specialty: 'Pediatrician (MBBS, MCPS, FCPS Paediatrics)',
              // Replace with actual image URLs
              imageUrl:
                  'https://placehold.co/100x100/FFDAB9/333333?text=Dr.+A.M',
              address: 'Shifa International Hospital, H-8/4, Islamabad',
            ),
            const SizedBox(height: 16),
            _buildDoctorCard(
              name: 'Dr. Usman Baig',
              specialty: 'Dermatologist (MBBS, MCPS, FCPS Dermatology)',
              // Replace with actual image URLs
              imageUrl:
                  'https://placehold.co/100x100/90EE90/333333?text=Dr.+U.B',
              address: 'Skin & Laser Clinic, F-10 Markaz, Islamabad',
            ),
            const SizedBox(height: 16),
            _buildDoctorCard(
              name: 'Dr. Sana Javed',
              specialty: 'Gynecologist (MBBS, FCPS Obstetrics & Gynaecology)',
              // Replace with actual image URLs
              imageUrl:
                  'https://placehold.co/100x100/FFC0CB/333333?text=Dr.+S.J',
              address: 'Lady Dufferin Hospital, Chand Bibi Road, Karachi',
            ),
            const SizedBox(height: 16),
            _buildDoctorCard(
              name: 'Dr. Ali Hassan Qureshi',
              specialty: 'Orthopedic Surgeon (MBBS, FCPS Orthopedics)',
              // Replace with actual image URLs
              imageUrl:
                  'https://placehold.co/100x100/D3D3D3/333333?text=Dr.+A.H.Q',
              address: 'Aga Khan University Hospital, Stadium Road, Karachi',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard({
    required String name,
    required String specialty,
    required String imageUrl,
    required String address,
  }) {
    return Card(
      color: const Color(0xFF3F3F5F),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,

                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              address,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement consultation booking
                },
                child: const Text('Book Consultation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
