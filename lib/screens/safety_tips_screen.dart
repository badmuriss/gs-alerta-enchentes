import 'package:flutter/material.dart';
import '../ui/theme.dart';
import '../ui/icons.dart';
import '../ui/responsive.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas de Segurança'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.darkGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primaryBlack, AppTheme.darkGray],
          ),
        ),
        child: ResponsiveContainer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(AppTheme.paddingL),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.paddingM),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlack.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        ),
                        child: const Icon(
                          AppIcons.safety,
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
                              'Guia de Segurança',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.primaryBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppTheme.paddingXS),
                            Text(
                              'Informações essenciais para sua proteção',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryBlack.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.paddingL),

                // Emergency Contacts Section
                _buildEmergencyContactsCard(context),
                const SizedBox(height: AppTheme.paddingL),

                // Safety Tips Sections
                const SafetyTipTile(
                  title: 'Antes de uma Enchente',
                  subtitle: 'Preparação e Prevenção',
                  icon: AppIcons.shield,
                  color: AppTheme.primaryGreen,
                  tips: [
                    'Tenha um kit de emergência preparado com água, alimentos não perecíveis, medicamentos e lanternas.',
                    'Conheça as rotas de evacuação da sua área e pontos de encontro seguros.',
                    'Mantenha documentos importantes em local seguro e à prova d\'água.',
                    'Desligue a eletricidade, gás e água se houver risco iminente de inundação.',
                    'Monitore constantemente os alertas meteorológicos e de defesa civil.',
                    'Tenha sempre carregadores portáteis e rádio a pilha funcionando.',
                  ],
                ),
                const SizedBox(height: AppTheme.paddingM),

                const SafetyTipTile(
                  title: 'Durante uma Enchente',
                  subtitle: 'Ações de Emergência',
                  icon: AppIcons.evacuation,
                  color: AppTheme.warningOrange,
                  tips: [
                    'Evite qualquer contato com águas de enchente - podem estar contaminadas.',
                    'NUNCA atravesse áreas alagadas a pé ou de carro - a correnteza pode ser fatal.',
                    'Procure imediatamente abrigo em locais elevados e seguros.',
                    'Mantenha-se informado através de rádio e fontes oficiais.',
                    'Se estiver preso, sinalize sua localização e aguarde resgate.',
                    'Não use elevadores em prédios que possam estar alagados.',
                  ],
                ),
                const SizedBox(height: AppTheme.paddingM),

                const SafetyTipTile(
                  title: 'Após uma Enchente',
                  subtitle: 'Recuperação Segura',
                  icon: AppIcons.firstAid,
                  color: AppTheme.secondaryGreen,
                  tips: [
                    'Verifique se sua casa está estruturalmente segura antes de retornar.',
                    'Cuidado com animais peçonhentos que podem ter se abrigado em sua casa.',
                    'Limpe e desinfete tudo que foi molhado para evitar doenças.',
                    'NUNCA consuma alimentos que tiveram contato com a água da enchente.',
                    'Documente os danos com fotos para o seguro antes de limpar.',
                    'Procure atendimento médico se tiver contato com água contaminada.',
                  ],
                ),
                const SizedBox(height: AppTheme.paddingM),

                const SafetyTipTile(
                  title: 'Kit de Emergência',
                  subtitle: 'Itens Essenciais',
                  icon: AppIcons.firstAid,
                  color: AppTheme.darkGreen,
                  tips: [
                    'Água potável (4 litros por pessoa por dia, para 3 dias)',
                    'Alimentos não perecíveis para 3 dias (enlatados, barras de cereal)',
                    'Medicamentos essenciais e kit de primeiros socorros',
                    'Lanternas, pilhas extras e rádio portátil',
                    'Documentos importantes em sacos plásticos',
                    'Roupas extras, cobertores e produtos de higiene',
                    'Dinheiro em espécie e carregadores portáteis',
                  ],
                ),
                const SizedBox(height: AppTheme.paddingL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyContactsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.errorRed.withValues(alpha: 0.2),
            AppTheme.errorRed.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(
          color: AppTheme.errorRed.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.paddingS),
                decoration: BoxDecoration(
                  color: AppTheme.errorRed,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
                child: const Icon(
                  AppIcons.emergency,
                  color: AppTheme.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.paddingM),
              Expanded(
                child: Text(
                  'Contatos de Emergência',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.errorRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.paddingM),
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingM),
            decoration: BoxDecoration(
              color: AppTheme.mediumGray,
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Column(
              children: [
                _buildEmergencyContact('Bombeiros', '193', AppIcons.emergency),
                _buildDivider(),
                _buildEmergencyContact('SAMU', '192', AppIcons.firstAid),
                _buildDivider(),
                _buildEmergencyContact('Polícia Militar', '190', AppIcons.shield),
                _buildDivider(),
                _buildEmergencyContact('Defesa Civil', '199', AppIcons.safety),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingS),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 20),
          const SizedBox(width: AppTheme.paddingM),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.paddingM,
              vertical: AppTheme.paddingS,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: AppTheme.primaryBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: AppTheme.paddingXS),
      color: AppTheme.lightGray.withValues(alpha: 0.3),
    );
  }
}

class SafetyTipTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> tips;

  const SafetyTipTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.tips,
  }) : super(key: key);

  @override
  State<SafetyTipTile> createState() => _SafetyTipTileState();
}

class _SafetyTipTileState extends State<SafetyTipTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(
          color: widget.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: _toggleExpansion,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.paddingL),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color.withValues(alpha: 0.2),
                    widget.color.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppTheme.radiusM),
                  topRight: const Radius.circular(AppTheme.radiusM),
                  bottomLeft: _isExpanded ? Radius.zero : const Radius.circular(AppTheme.radiusM),
                  bottomRight: _isExpanded ? Radius.zero : const Radius.circular(AppTheme.radiusM),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.paddingM),
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppTheme.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppTheme.paddingXS),
                        Text(
                          widget.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.paddingL),
              child: Column(
                children: widget.tips.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tip = entry.value;
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: index < widget.tips.length - 1 ? AppTheme.paddingM : 0,
                    ),
                    padding: const EdgeInsets.all(AppTheme.paddingM),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlack.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      border: Border.all(
                        color: widget.color.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          child: Icon(
                            AppIcons.success,
                            color: widget.color,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: AppTheme.paddingM),
                        Expanded(
                          child: Text(
                            tip,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}