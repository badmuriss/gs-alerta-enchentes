# 🌊 Aplicativo Alerta Enchentes

Repositório do projeto de um aplicativo móvel para prevenção e alerta de enchentes, desenvolvido para a Global Solution.

## 📖 Tabela de Conteúdos

- [💡 Sobre o Projeto](#-sobre-o-projeto)
- [🎯 Funcionalidades Principais](#-funcionalidades-principais)
- [🛠️ Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [🏛️ Arquitetura](#-arquitetura)
- [🚀 Como Executar o Projeto](#-como-executar-o-projeto)
- [🔮 Melhorias Futuras](#-melhorias-futuras)
- [👥 Equipe](#-equipe)

## 💡 Sobre o Projeto

As enchentes urbanas no Brasil representam um desafio social e ambiental crescente, causando graves danos humanos, materiais e ambientais. Este projeto propõe uma solução tecnológica para mitigar esses impactos: um aplicativo móvel proativo e inteligente para prevenção e alerta de enchentes.

O objetivo é capacitar os cidadãos com informações em tempo real e históricas, permitindo a tomada de decisões seguras e contribuindo para a construção de comunidades mais resilientes. A solução utiliza um modelo de Inteligência Artificial para gerar alertas preditivos, permitindo que os usuários ajam antes que a situação se agrave, um diferencial chave em relação a sistemas de alerta reativos.

## 🎯 Funcionalidades Principais

- **Alertas Preditivos:** Notificações de risco de enchente com antecedência configurável (1 semana, 1 dia, tempo real).
- **Monitoramento Personalizado:** Usuários podem monitorar um ou múltiplos endereços de interesse (residência, trabalho, familiares).
- **Dashboard de Risco:** Painel principal com um resumo conciso do nível de risco (representado por cor e porcentagem), previsão de chuvas e outras condições climáticas.
- **Mapa Interativo de Risco (Premium):** Visualização de um mapa do Brasil com zonas de risco coloridas de acordo com a probabilidade de enchente.
- **Orientações de Segurança:** Uma seção de FAQ com informações vitais sobre como agir antes, durante e depois de uma enchente, com contatos de emergência.

## 🛠️ Tecnologias Utilizadas

| Tecnologia         | Finalidade                                                            |
|--------------------|----------------------------------------------------------------------|
| Dart               | Linguagem de programação principal.                                  |
| Flutter            | Framework para desenvolvimento de UI multiplataforma (Android & iOS).|
| Firebase           | Backend como serviço para:                                           |
| ├── Authentication | Gestão de login e cadastro de usuários.                              |
| ├── Cloud Firestore| Banco de dados NoSQL para armazenar dados do usuário.                |
| └── FCM            | Envio de notificações push para os alertas críticos.                 |
| Weatherbit.io API  | Fonte exclusiva de dados meteorológicos (atuais, previsões e históricos). |
| Modelo de IA (ML)  | Algoritmo treinado para analisar os dados e prever o risco de enchente. |

## 🏛️ Arquitetura

O projeto segue a arquitetura **MVVM (Model-View-ViewModel)**, que garante uma excelente separação de responsabilidades, testabilidade e escalabilidade do código.

- **Model:** Representa os dados (ex: dados da Weatherbit.io) e a lógica de negócios.
- **View:** As telas do aplicativo (Widgets em Flutter) que exibem as informações ao usuário.
- **ViewModel:** Intermediário que prepara os dados do Model para a View e gerencia o estado da UI.

## 🚀 Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- IDE: Android Studio ou VS Code com as extensões do Flutter/Dart.
- Conta no Firebase
- Chave de API da Weatherbit.io

### Instalação

Clone o repositório:

```bash
git clone https://github.com/badmuriss/gs-alerta-enchentes
cd gs-alerta-enchentes
```

Instale as dependências:

```bash
flutter pub get
```

Configure o Firebase:

1. Crie um projeto no console do Firebase.
2. Adicione um app para Android e/ou iOS.
3. Baixe e adicione o arquivo de configuração:
    - **Android:** `android/app/google-services.json`
    - **iOS:** `ios/Runner/GoogleService-Info.plist`

Configure as variáveis de ambiente:

1. Crie um arquivo `.env` na raiz do projeto.
2. Use o arquivo `.env.example` como modelo:

```env
WEATHERBIT_API_KEY=SUA_CHAVE_API_AQUI
```

Execute o aplicativo:

```bash
flutter run
```

## 🔮 Melhorias Futuras

- **Integração com Órgãos Oficiais:** Parcerias com a Defesa Civil.
- **Aprimoramento do Modelo de IA com Dados Locais.**
- **Funcionalidade Offline:** Cache de alertas e orientações.
- **Módulo de Crowdsourcing:** Usuários reportam ocorrências locais em tempo real.

## 👥 Equipe

| Nome              |
|-------------------|
| Murilo Moura      |
| Gabriel Freitas   |
| Roberto Felix     |
| Mateus Vicente    |
| Felipe Cavalcanti |
