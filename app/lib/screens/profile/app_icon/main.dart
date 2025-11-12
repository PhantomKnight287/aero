import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:aero/constants/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppIconScreen extends StatefulWidget {
  const AppIconScreen({super.key});

  @override
  State<AppIconScreen> createState() => _AppIconScreenState();
}

class _AppIconScreenState extends State<AppIconScreen> {
  String? _selectedIcon;
  bool _loading = false;

  final List<Map<String, String>> _icons = [
    {'id': 'ZERO_TWO', 'name': 'Default', 'asset': 'assets/logos/0-1.png'},
    {'id': 'ZERO_THREE', 'name': 'Icon 2', 'asset': 'assets/logos/0-2.png'},
    {'id': 'ZERO_FOUR', 'name': 'Icon 3', 'asset': 'assets/logos/0-3.png'},
    {'id': 'DEFAULT', 'name': 'Icon 4', 'asset': 'assets/logos/0-4.png'},
    {'id': 'ZERO_FIVE', 'name': 'Icon 5', 'asset': 'assets/logos/0-5.png'},
    {'id': 'ZERO_SIX', 'name': 'Icon 6', 'asset': 'assets/logos/0-6.png'},
    {'id': 'ONE_ONE', 'name': 'Icon 7', 'asset': 'assets/logos/1-1.png'},
    {'id': 'ONE_TWO', 'name': 'Icon 8', 'asset': 'assets/logos/1-2.png'},
    {'id': 'ONE_THREE', 'name': 'Icon 9', 'asset': 'assets/logos/1-3.png'},
    {'id': 'ONE_FOUR', 'name': 'Icon 10', 'asset': 'assets/logos/1-4.png'},
    {'id': 'ONE_FIVE', 'name': 'Icon 11', 'asset': 'assets/logos/1-5.png'},
    {'id': 'ONE_SIX', 'name': 'Icon 12', 'asset': 'assets/logos/1-6.png'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedIcon();
  }

  Future<void> _loadSelectedIcon() async {
    final prefs = await SharedPreferences.getInstance();
    final selected = prefs.getString('selected_app_icon') ?? 'DEFAULT';
    setState(() {
      _selectedIcon = selected;
    });
  }

  Future<void> _changeIcon(String iconId) async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    try {
      // Change the app icon using VariableAppIcon
      final iconName = iconId == 'DEFAULT' ? "DEFAULT" : iconId;
      if (await FlutterDynamicIconPlus.supportsAlternateIcons) {
        final channel = MethodChannel(METHOD_CHANNEL);
        await channel.invokeMethod("changeAppIcon", {'iconId': iconName});
        print("changed icon to $iconName");
      }

      // Save the selection
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_app_icon', iconId);

      setState(() {
        _selectedIcon = iconId;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('App icon changed successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change app icon: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'App Icon',
          style: TextStyle(
            fontFamily: "CalSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select an app icon',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: "Geist",
                      ),
                    ),
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: _icons.length,
                      itemBuilder: (context, index) {
                        final icon = _icons[index];
                        final isSelected = _selectedIcon == icon['id'];

                        return InkWell(
                          onTap: () => _changeIcon(icon['id']!),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      icon['asset']!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
