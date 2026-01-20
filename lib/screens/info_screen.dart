import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  // Function to launch URLs
  Future<void> _launchUrl(String url) async {
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber.shade800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ақпарат',
          style: TextStyle(
            color: Colors.amber.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo and Title
              Center(
                child: Column(
                  children: [
                    Text(
                      '🧠',
                      style: const TextStyle(fontSize: 60),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scaleXY(
                      end: 1.1,
                      duration: 1200.ms,
                      curve: Curves.easeInOut,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Қазақша Куиз',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [Colors.amber.shade800, Colors.orange],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Нұсқа 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms),

              const SizedBox(height: 30),

              // About App Section
              _buildSectionTitle('Бағдарлама туралы'),
              _buildInfoCard(
                child: const Text(
                  'Бұл қазақ тілінде білімді тексеруге арналған куиз қосымшасы. '
                  'Бұл қосымша қазақ тілін үйренушілерге және білімін тексергісі '
                  'келетіндерге арналған. Әртүрлі тақырыптарды қамтиды.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),

              const SizedBox(height: 24),

              // Contributors Section
              _buildSectionTitle('Авторлар'),
              _buildInfoCard(
                child: Column(
                  children: [
                    _buildContributor(
                      name: 'Сериков Расулла Серикович',
                      role: 'Іле ауданы Т.Айбергенов атындағы №48 орта мектептің тарих пәні оқытушысы, комиссия мүшесі',
                    ),
                    const Divider(height: 24),
                    _buildContributor(
                      name: 'Елемес Жәнібек Кажмуханович',
                      role: 'Іле ауданы Т.Айбергенов атындағы №48 орта мектептің қазақ тілі мен әдебиеті пәні мұғалімі, комиссия мүшесі',
                    ),
                    const Divider(height: 24),
                    _buildContributor(
                      name: 'Өмірзаков Есет Исагалиұлы',
                      role: 'Іле ауданы №7 орта мектептің дене тәрбиесі мұғалімі, комиссия мүшесі',
                    ),
                    const Divider(height: 24),
                    _buildContributor(
                      name: 'Серік Алишер Маратұлы',
                      role: 'Іле ауданы №7 орта мектептің математика пәні мұғалімі, комиссия мүшесі',
                    ),
                    const Divider(height: 24),
                    _buildContributor(
                      name: 'Қуанышбаев Санауир Айбасович',
                      role: 'Іле ауданы Т.Айбергенов атындағы №48 орта мектептің информатика пәні мұғалімі, комиссия мүшесі',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Contact Section
              _buildSectionTitle('Байланыс'),
              _buildInfoCard(
                child: Column(
                  children: [
                    _buildContactItem(
                      icon: Icons.email,
                      title: 'Электрондық пошта',
                      subtitle: 'info@kazakquiz.kz',
                      onTap: () => _launchUrl('mailto:info@kazakquiz.kz'),
                    ),
                    const Divider(height: 24),
                    _buildContactItem(
                      icon: Icons.language,
                      title: 'Веб-сайт',
                      subtitle: 'www.kazakquiz.kz',
                      onTap: () => _launchUrl('https://www.kazakquiz.kz'),
                    ),
                    const Divider(height: 24),
                    _buildContactItem(
                      icon: Icons.phone,
                      title: 'Телефон',
                      subtitle: '+7 (777) 123-4567',
                      onTap: () => _launchUrl('tel:+77771234567'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Legal Information
              _buildSectionTitle('Құқықтық ақпарат'),
              _buildInfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegalItem(
                      title: 'Құпиялылық саясаты',
                      onTap: () => _launchUrl('https://www.kazakquiz.kz/privacy'),
                    ),
                    const SizedBox(height: 12),
                    _buildLegalItem(
                      title: 'Пайдалану шарттары',
                      onTap: () => _launchUrl('https://www.kazakquiz.kz/terms'),
                    ),
                    const SizedBox(height: 12),
                    _buildLegalItem(
                      title: 'Лицензиялар',
                      onTap: () => _launchUrl('https://www.kazakquiz.kz/licenses'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Version History
              _buildSectionTitle('Нұсқа тарихы'),
              _buildInfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _buildVersionItem(
                      version: '1.0.0',
                      date: '2025-05-01',
                      description: 'Алғашқы нұсқасы',
                    ),
                    Divider(height: 16),
                    _buildVersionItem(
                      version: '0.9.0',
                      date: '2025-04-15',
                      description: 'Бета-тестілеу нұсқасы',
                    ),
                    Divider(height: 16),
                    _buildVersionItem(
                      version: '0.5.0',
                      date: '2025-03-20',
                      description: 'Альфа-нұсқа',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Footer
              Center(
                child: Text(
                  '© 2025 Қазақша Куиз. Барлық құқықтар қорғалған.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.amber.shade800,
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2);
  }

  // Helper method to build info cards
  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2);
  }

  // Helper method to build contributor items
  Widget _buildContributor({
    required String name,
    required String role, // Made optional
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.amber.shade100,
          child: Text(
            name.isNotEmpty ? name[0] : '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                role,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build contact items
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.amber.shade700,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build legal items
  Widget _buildLegalItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              Icons.description_outlined,
              color: Colors.amber.shade700,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// Helper method to build version history items
class _buildVersionItem extends StatelessWidget {
  final String version;
  final String date;
  final String description;

  const _buildVersionItem({
    required this.version,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Нұсқа $version',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}