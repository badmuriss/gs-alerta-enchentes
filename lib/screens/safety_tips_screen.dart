import 'package:flutter/material.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dicas de Segurança')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          SafetyTipTile(
            title: 'Antes de uma Enchente',
            icon: Icons.shield_outlined,
            tips: [
              'Tenha um kit de emergência preparado.',
              'Conheça as rotas de evacuação da sua área.',
              'Mantenha documentos importantes em local seguro e à prova d\'água.',
              'Desligue a eletricidade, gás e água se houver risco de inundação.',
            ],
          ),
          SafetyTipTile(
            title: 'Durante uma Enchente',
            icon: Icons.directions_walk,
            tips: [
              'Evite contato com águas de enchente.',
              'Não atravesse áreas alagadas.',
              'Procure abrigo em locais elevados.',
              'Mantenha-se informado através de fontes oficiais.',
            ],
          ),
          SafetyTipTile(
            title: 'Após uma Enchente',
            icon: Icons.home_repair_service_outlined,
            tips: [
              'Verifique se sua casa está segura antes de retornar.',
              'Cuidado com animais peçonhentos.',
              'Limpe e desinfete tudo que foi molhado.',
              'Não consuma alimentos que tiveram contato com a água da enchente.',
            ],
          ),
        ],
      ),
    );
  }
}

class SafetyTipTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> tips;

  const SafetyTipTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.tips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        children: tips.map((tip) => ListTile(
              title: Text(tip),
              leading: Icon(Icons.check_circle_outline, color: Colors.green.shade700),
            )).toList(),
      ),
    );
  }
}