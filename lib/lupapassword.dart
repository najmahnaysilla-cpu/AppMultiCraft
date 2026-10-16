import 'package:flutter/material.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  // 1 = Lupa1
  // 2 = Lupa2
  // 3 = Lupa3
  int currentStep = 1;

  final Color purple = const Color(0xFF6757E8);

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _kirimEmail() {
    if (currentStep == 1) {
      setState(() {
        currentStep = 2;
      });
      return;
    }

    if (currentStep == 2) {
      final email = emailController.text.trim();

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan email terlebih dahulu.'),
          ),
        );
        return;
      }

      final emailParts = email.split('@');
      if (emailParts.length != 2 ||
          emailParts[0].isEmpty ||
          !emailParts[1].contains('.') ||
          emailParts[1].startsWith('.') ||
          emailParts[1].endsWith('.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan alamat email yang valid.'),
          ),
        );
        return;
      }

      // Tampilan simulasi berhasil mengirim email.
      setState(() {
        currentStep = 3;
      });
    }
  }

  Widget _emailField() {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: Color(0xFF6757E8),
          fontSize: 13,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: currentStep == 2 ? 'Masukkan Email' : 'Email',
          hintStyle: const TextStyle(
            color: Color(0xFF9690B2),
            fontSize: 13,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              'assets/images/email.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: purple,
                );
              },
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 46,
            minHeight: 48,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: purple,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: purple,
              width: 1.6,
            ),
          ),
        ),
      ),
    );
  }

  Widget _formContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Lupa kata sandi?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: purple,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 9),

        const Text(
          'Masukkan email untuk reset kata sandi',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF9690B2),
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 28),

        if (currentStep == 3) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF8BC34A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Kami sudah mengirim surat yang berisi tautan '
              'untuk mereset kata sandi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        _emailField(),

        const SizedBox(height: 16),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: currentStep == 3 ? null : _kirimEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  currentStep == 3
                      ? const Color(0xFFA89CF0)
                      : purple,
              disabledBackgroundColor: const Color(0xFFA89CF0),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              currentStep == 3 ? 'Terkirim' : 'Kirim',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        if (currentStep == 3) ...[
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              '← Kembali ke halaman login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: purple,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        const Spacer(),

                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 360,
                            ),
                            child: _formContent(),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
