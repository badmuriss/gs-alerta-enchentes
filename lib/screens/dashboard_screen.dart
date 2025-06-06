import 'package:alerta_enchentes_novo/screens/weather_screen.dart';
import 'package:alerta_enchentes_novo/widgets/weather_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_level_provider.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/status_card.dart';
import '../ui/theme.dart';
import '../ui/icons.dart';
import '../ui/responsive.dart';
import 'safety_tips_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final weatherProvider = context.read<WeatherProvider>();
      if (weatherProvider.weather == null) {
        weatherProvider.fetchWeatherForCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final waterLevel = context.watch<WaterLevelProvider>().waterLevel;
    final weatherProvider = context.watch<WeatherProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return ResponsiveContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(AppTheme.paddingL),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visão Geral',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: AppTheme.primaryBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.paddingS),
                  Text(
                    'Sistema de Monitoramento de Enchentes',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.primaryBlack,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.paddingL),

            // Water Level Status Section
            _buildSectionHeader(
              context,
              'Status do Nível da Água',
              AppIcons.water,
              subtitle: 'Simulação em tempo real',
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: AppTheme.paddingM),
            StatusCard(waterLevel: waterLevel),
            const SizedBox(height: AppTheme.paddingL),

            // Weather Section
            _buildSectionHeader(
              context,
              'Clima na sua Região',
              AppIcons.weather,
              isDarkMode: isDarkMode,
              action: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(AppTheme.paddingS),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  ),
                  child: const Icon(
                    AppIcons.refresh,
                    color: AppTheme.primaryBlack,
                    size: 20,
                  ),
                ),
                onPressed: () => context.read<WeatherProvider>().fetchWeatherForCurrentLocation(),
                tooltip: 'Atualizar Clima',
              ),
            ),
            const SizedBox(height: AppTheme.paddingM),
            _buildWeatherContent(weatherProvider, isDarkMode),
            const SizedBox(height: AppTheme.paddingL),

            // Quick Actions Section
            _buildSectionHeader(
              context,
              'Ações Rápidas',
              AppIcons.safety,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: AppTheme.paddingM),
            _buildQuickActions(context, isDarkMode),
            const SizedBox(height: AppTheme.paddingL),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon, {
    String? subtitle,
    Widget? action,
    required bool isDarkMode,
  }) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.paddingS),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryBlack,
            size: 24,
          ),
        ),
        const SizedBox(width: AppTheme.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppTheme.paddingXS),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDarkMode 
                        ? const Color(0xB3FFFFFF) // 70% opacity white
                        : const Color(0xB3000000), // 70% opacity black
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) action,
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDarkMode) {
    return ResponsiveLayout(
      mobile: Column(
        children: [
          _buildActionCard(
            context,
            'Dicas de Segurança',
            'Aprenda como se proteger',
            AppIcons.safety,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SafetyTipsScreen()),
            ),
            isDarkMode,
          ),
          const SizedBox(height: AppTheme.paddingM),
          _buildActionCard(
            context,
            'Emergência',
            'Contatos de emergência',
            AppIcons.emergency,
            () => _showEmergencyContacts(context, isDarkMode),
            isDarkMode,
          ),
        ],
      ),
      tablet: Row(
        children: [
          Expanded(
            child: _buildActionCard(
              context,
              'Dicas de Segurança',
              'Aprenda como se proteger',
              AppIcons.safety,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SafetyTipsScreen()),
              ),
              isDarkMode,
            ),
          ),
          const SizedBox(width: AppTheme.paddingM),
          Expanded(
            child: _buildActionCard(
              context,
              'Emergência',
              'Contatos de emergência',
              AppIcons.emergency,
              () => _showEmergencyContacts(context, isDarkMode),
              isDarkMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
    bool isDarkMode,
  ) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.paddingL),
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
          border: Border.all(
            color: const Color(0x4D00FF88), // 30% opacity primaryGreen
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.paddingM),
              decoration: BoxDecoration(
                color: const Color(0x3300FF88), // 20% opacity primaryGreen
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: AppTheme.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.paddingXS),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDarkMode 
                          ? const Color(0xB3FFFFFF) // 70% opacity white
                          : const Color(0xB3000000), // 70% opacity black
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: theme.colorScheme.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencyContacts(BuildContext context, bool isDarkMode) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? AppTheme.mediumGray : AppTheme.lightBackground,
        title: Row(
          children: [
            Icon(AppIcons.emergency, color: theme.colorScheme.primary),
            const SizedBox(width: AppTheme.paddingS),
            Text(
              'Contatos de Emergência',
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact('Bombeiros', '193', isDarkMode),
            _buildEmergencyContact('SAMU', '192', isDarkMode),
            _buildEmergencyContact('Polícia Militar', '190', isDarkMode),
            _buildEmergencyContact('Defesa Civil', '199', isDarkMode),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Fechar',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number, bool isDarkMode) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingXS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: isDarkMode ? AppTheme.white : AppTheme.primaryBlack,
            ),
          ),
          Text(
            number,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent(WeatherProvider provider, bool isDarkMode) {
    final theme = Theme.of(context);
    
    if (provider.isLoading) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.paddingL),
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
        ),
      );
    } else if (provider.errorMessage != null) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.paddingL),
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
          border: Border.all(color: const Color(0x80FF4444)), // 50% opacity errorRed
        ),
        child: Row(
          children: [
            Icon(AppIcons.error, color: AppTheme.errorRed),
            const SizedBox(width: AppTheme.paddingM),
            Expanded(
              child: Text(
                'Erro ao carregar o clima: ${provider.errorMessage}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (provider.weather != null) {
      return WeatherSummary(
        weather: provider.weather!,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherScreen(),
            ),
          );
        },
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(AppTheme.paddingL),
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
        ),
        child: Row(
          children: [
            Icon(AppIcons.info, color: theme.colorScheme.primary),
            const SizedBox(width: AppTheme.paddingM),
            Expanded(
              child: Text(
                'Clique em atualizar para buscar os dados do clima.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }
  }
}