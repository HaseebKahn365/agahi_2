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
            // a huge back button alighned with the top left corner back.png
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            const Text(
              '• Elevated body temperature\n• Chills and shivering\n• Headache\n• Muscle aches\n• Loss of appetite\n• Dehydration\n• General weakness',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Treatment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medications:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16),
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
      appBar: AppBar(title: const Text('Belly Pain Information')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKHkeeQ_ViPsCZMBqHWh3q7YOfQBy22YBPiA&s', // Replace with actual URL
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Abdominal discomfort or cramping\n• Bloating\n• Gas\n• Nausea\n• Changes in bowel movements\n• Loss of appetite',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Treatment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Drink plenty of fluids\n• Apply heat to the abdomen\n• Try over-the-counter antacids\n• Eat bland foods\n• Avoid fatty or spicy foods\n• Get adequate rest',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medications:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Antacids (Tums, Rolaids)\n• H2 blockers (Pepcid, Zantac)\n• Proton pump inhibitors (Prilosec)\n• Simethicone (Gas-X)\n• Loperamide (Imodium) for diarrhea',
              style: TextStyle(fontSize: 16),
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
      // appBar: AppBar(title: const Text('Available Doctors')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDoctorCard(
            name: 'Dr. Sarah Johnson',
            specialty: 'General Physician',
            imageUrl: 'https://example.com/doctor1.jpg',
            address: '123 Health St, Medical Center',
          ),
          const SizedBox(height: 16),
          _buildDoctorCard(
            name: 'Dr. Michael Chen',
            specialty: 'Gastroenterologist',
            imageUrl: 'https://example.com/doctor2.jpg',
            address: '456 Wellness Ave, Clinic Building',
          ),
          const SizedBox(height: 16),
          _buildDoctorCard(
            name: 'Dr. Priya Patel',
            specialty: 'Pediatrician',
            imageUrl: 'https://example.com/doctor3.jpg',
            address: '789 Care Blvd, Children\'s Hospital',
          ),
        ],
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
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(address, style: const TextStyle(fontSize: 14)),
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
