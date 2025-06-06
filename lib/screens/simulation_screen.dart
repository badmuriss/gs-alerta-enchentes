import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_level_provider.dart';
import '../providers/theme_provider.dart';
import '../ui/theme.dart';
import '../ui/icons.dart';
import '../ui/responsive.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final waterLevelProvider = context.watch<WaterLevelProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;
    final waterLevel = waterLevelProvider.waterLevel;
    final theme = Theme.of(context);

    return ResponsiveContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(AppTheme.paddingL),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.paddingM),
                    decoration: BoxDecoration(
                      color: const Color(0x33000000), // 20% opacity black
                      borderRadius: BorderRadius.circular(AppTheme.radiusS),
                    ),
                    child: const Icon(
                      AppIcons.simulate,
                      color: AppTheme.primaryBlack,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simulação de Nível',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppTheme.paddingXS),
                        Text(
                          'Teste diferentes cenários de enchente',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xCC000000), // 80% opacity black
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.paddingL),

            // Current Level Display
            Container(
              padding: const EdgeInsets.all(AppTheme.paddingL),
              decoration: BoxDecoration(
                gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
                border: Border.all(
                  color: _getWaterLevelColorWithOpacity(waterLevel, 0.5),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nível Atual',
                        style: theme.textTheme.titleLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.paddingM,
                          vertical: AppTheme.paddingS,
                        ),
                        decoration: BoxDecoration(
                          color: _getWaterLevelColor(waterLevel),
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        ),
                        child: Text(
                          '${waterLevel.toStringAsFixed(1)}%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppTheme.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.paddingM),
                  Text(
                    _getWaterLevelStatus(waterLevel),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _getWaterLevelColor(waterLevel),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.paddingL),

            // Water Tank Visualization
            ResponsiveLayout(
              mobile: _buildMobileLayout(context, waterLevel, waterLevelProvider, isDarkMode),
              tablet: _buildTabletLayout(context, waterLevel, waterLevelProvider, isDarkMode),
            ),

            const SizedBox(height: AppTheme.paddingL),

            // Quick Preset Buttons
            _buildPresetButtons(context, waterLevelProvider, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double waterLevel, WaterLevelProvider provider, bool isDarkMode) {
    return Column(
      children: [
        _buildWaterTank(context, waterLevel, isDarkMode),
        const SizedBox(height: AppTheme.paddingL),
        _buildSliderControl(context, waterLevel, provider, isDarkMode),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, double waterLevel, WaterLevelProvider provider, bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildWaterTank(context, waterLevel, isDarkMode),
        ),
        const SizedBox(width: AppTheme.paddingL),
        Expanded(
          flex: 3,
          child: _buildSliderControl(context, waterLevel, provider, isDarkMode),
        ),
      ],
    );
  }

  Widget _buildWaterTank(BuildContext context, double waterLevel, bool isDarkMode) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      decoration: BoxDecoration(
        gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
      ),
      child: Column(
        children: [
          Text(
            'Visualização do Reservatório',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.paddingL),
          Center(
            child: Container(
              height: 300,
              width: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode 
                      ? [const Color(0x4D404040), const Color(0x802D2D2D)] // 30% and 50% opacity
                      : [const Color(0x4DE0E0E0), const Color(0x80CCCCCC)], // 30% and 50% opacity
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                border: Border.all(
                  color: const Color(0x8000FF88), // 50% opacity primaryGreen
                  width: 3,
                ),
                boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusM - 3),
                child: Stack(
                  children: [
                    // Water level
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: waterLevel / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _getWaterLevelColorWithOpacity(waterLevel, 0.7),
                                _getWaterLevelColor(waterLevel),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Water surface animation
                    if (waterLevel > 0)
                      Positioned(
                        bottom: (300 * (waterLevel / 100)) - 10,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getWaterLevelColorWithOpacity(waterLevel, 0.3),
                                _getWaterLevelColorWithOpacity(waterLevel, 0.7),
                                _getWaterLevelColorWithOpacity(waterLevel, 0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // Level markers
                    ...List.generate(4, (index) {
                      final markerLevel = (index + 1) * 25.0;
                      return Positioned(
                        bottom: (300 * (markerLevel / 100)) - 1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: const Color(0x80FFFFFF), // 50% opacity white
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.paddingM),
          // Level indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLevelMarker('0%', AppTheme.primaryGreen),
              _buildLevelMarker('25%', AppTheme.secondaryGreen),
              _buildLevelMarker('50%', AppTheme.warningOrange),
              _buildLevelMarker('75%', AppTheme.errorRed),
              _buildLevelMarker('100%', AppTheme.errorRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelMarker(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: AppTheme.paddingXS),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderControl(BuildContext context, double waterLevel, WaterLevelProvider provider, bool isDarkMode) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      decoration: BoxDecoration(
        gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                AppIcons.water,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: AppTheme.paddingS),
              Text(
                'Controle de Nível',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.paddingL),
          
          // Custom Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _getWaterLevelColor(waterLevel),
              inactiveTrackColor: isDarkMode 
                  ? const Color(0x4D404040) // 30% opacity lightGray
                  : const Color(0x4DCCCCCC), // 30% opacity lightGrayBorder
              thumbColor: _getWaterLevelColor(waterLevel),
              overlayColor: _getWaterLevelColorWithOpacity(waterLevel, 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              trackHeight: 8,
            ),
            child: Slider(
              value: waterLevel,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${waterLevel.round()}%',
              onChanged: (double value) {
                provider.setWaterLevel(value);
              },
            ),
          ),
          
          const SizedBox(height: AppTheme.paddingM),
          
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingM),
            decoration: BoxDecoration(
              color: const Color(0x1A00FF88), // 10% opacity primaryGreen
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
              border: Border.all(
                color: const Color(0x4D00FF88), // 30% opacity primaryGreen
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  AppIcons.info,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(
                  child: Text(
                    'Arraste o controle para simular diferentes níveis de água',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDarkMode 
                          ? const Color(0xCCFFFFFF) // 80% opacity white
                          : const Color(0xCC000000), // 80% opacity black
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetButtons(BuildContext context, WaterLevelProvider provider, bool isDarkMode) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      decoration: BoxDecoration(
        gradient: isDarkMode ? AppTheme.cardGradient : AppTheme.lightCardGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: isDarkMode ? AppTheme.cardShadow : AppTheme.lightCardShadow,
      ),
      child: Column(
        children: [
          Text(
            'Cenários Pré-definidos',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppTheme.paddingM),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _buildPresetButton(context, 'Normal', 15, AppTheme.primaryGreen, provider),
                const SizedBox(height: AppTheme.paddingS),
                _buildPresetButton(context, 'Atenção', 35, AppTheme.secondaryGreen, provider),
                const SizedBox(height: AppTheme.paddingS),
                _buildPresetButton(context, 'Alerta', 65, AppTheme.warningOrange, provider),
                const SizedBox(height: AppTheme.paddingS),
                _buildPresetButton(context, 'Crítico', 85, AppTheme.errorRed, provider),
              ],
            ),
            tablet: Row(
              children: [
                Expanded(child: _buildPresetButton(context, 'Normal', 15, AppTheme.primaryGreen, provider)),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(child: _buildPresetButton(context, 'Atenção', 35, AppTheme.secondaryGreen, provider)),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(child: _buildPresetButton(context, 'Alerta', 65, AppTheme.warningOrange, provider)),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(child: _buildPresetButton(context, 'Crítico', 85, AppTheme.errorRed, provider)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetButton(BuildContext context, String label, double level, Color color, WaterLevelProvider provider) {
    final theme = Theme.of(context);
    
    return ElevatedButton(
      onPressed: () => provider.setWaterLevel(level),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingM,
          vertical: AppTheme.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppTheme.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${level.toInt()}%',
            style: theme.textTheme.labelSmall?.copyWith(
              color: const Color(0xCCFFFFFF), // 80% opacity white
            ),
          ),
        ],
      ),
    );
  }

  Color _getWaterLevelColor(double level) {
    if (level >= 75) return AppTheme.errorRed;
    if (level >= 50) return AppTheme.warningOrange;
    if (level >= 25) return AppTheme.secondaryGreen;
    return AppTheme.primaryGreen;
  }
  
  Color _getWaterLevelColorWithOpacity(double level, double opacity) {
    int alpha = (opacity * 255).round();
    String alphaHex = alpha.toRadixString(16).padLeft(2, '0');
    
    if (level >= 75) {
      return Color(int.parse('${alphaHex}FF4444', radix: 16)); // errorRed with opacity
    }
    if (level >= 50) {
      return Color(int.parse('${alphaHex}FF8800', radix: 16)); // warningOrange with opacity
    }
    if (level >= 25) {
      return Color(int.parse('${alphaHex}00CC6A', radix: 16)); // secondaryGreen with opacity
    }
    return Color(int.parse('${alphaHex}00FF88', radix: 16)); // primaryGreen with opacity
  }

  String _getWaterLevelStatus(double level) {
    if (level >= 75) return 'PERIGO IMINENTE - Evacuação necessária';
    if (level >= 50) return 'ALERTA - Prepare-se para evacuar';
    if (level >= 25) return 'ATENÇÃO - Monitore as condições';
    return 'NORMAL - Situação segura';
  }
}