# SEEK7 Gold

<p align="center">
  <strong>Encontre. Faça. Ganhe.</strong><br>
  <sub>Um marketplace geográfico de oportunidades patrocinadas.</sub>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Google%20Maps-Integrated-4285F4?logo=googlemaps&logoColor=white" alt="Google Maps">
  <img src="https://img.shields.io/badge/Architecture-Feature--based-111827" alt="Architecture">
  <img src="https://img.shields.io/badge/Status-MVP-FFD21F" alt="MVP">
</p>

<p align="center">
  <a href="#produto">Produto</a> ·
  <a href="#experiência-do-app">Experiência</a> ·
  <a href="#como-funciona">Como funciona</a> ·
  <a href="#arquitetura">Arquitetura</a> ·
  <a href="#roadmap">Roadmap</a>
</p>

---

## Produto

O SEEK7 Gold conecta **pessoas, negócios e localização** em uma única experiência.

O mapa deixa de ser apenas uma ferramenta de navegação e passa a mostrar **oportunidades patrocinadas próximas**, representadas por pins dourados.

> **Negócio precisa de atenção → SEEK7 encontra pessoas relevantes → pessoa interage → negócio paga pela ação → usuário recebe recompensa.**

---

## Experiência do app

### Descobrir → Escolher → Interagir → Validar → Ganhar

<div align="center">
  <img src="https://github.com/user-attachments/assets/59453c01-abef-448d-8486-796e8ae70288" alt="SEEK7 Gold — tela do aplicativo" width="1000">
</div>

<p align="center"><sub>Prévia da experiência SEEK7 Gold</sub></p>

> Esta seção será ampliada com screenshots reais das principais telas do aplicativo à medida que forem adicionados ao repositório.

---

## Como funciona

```text
DESCOBRIR → ESCOLHER → INTERAGIR → VALIDAR → GANHAR
    ↑                                             ↓
    └──────────── novas oportunidades ───────────┘
```

| Etapa | O que acontece |
|---|---|
| **01 — Descobrir** | O usuário abre o mapa e encontra oportunidades próximas. |
| **02 — Escolher** | Cada pin dourado representa uma oportunidade disponível. |
| **03 — Interagir** | O usuário abre a oportunidade e executa a ação patrocinada. |
| **04 — Ganhar** | Após a conclusão válida, a recompensa é registrada na carteira. |
| **05 — Repetir** | O mapa é atualizado conforme novas oportunidades aparecem. |

---

## O diferencial

O SEEK7 não foi desenhado como uma simples lista de anúncios. O núcleo do produto é um **motor de decisão geográfico** que combina contexto, regras de campanha e disponibilidade para determinar quais oportunidades fazem sentido para cada usuário.

### Oportunidade certa, pessoa certa, momento certo

A proposta é criar um **mercado geográfico de atenção**, no qual a publicidade deixa de ser apenas exposição e passa a gerar uma ação mensurável.

As oportunidades podem ser selecionadas considerando:

- localização e distância;
- categoria e contexto;
- horário e disponibilidade;
- interesses e comportamento;
- regras da campanha;
- orçamento do anunciante;
- capacidade disponível;
- limites antifraude.

**A oportunidade certa para a pessoa certa, no momento certo.**

---

## Para usuários

- Mapa de oportunidades em tempo real
- Pins dourados personalizados
- Experiências patrocinadas
- Recompensas
- Carteira e histórico
- Perfil e preferências
- Geolocalização
- Controle de oportunidades
- Estrutura preparada para antifraude

## Para empresas

O anunciante poderá:

1. Criar campanhas.
2. Definir orçamento.
3. Definir recompensa por conclusão.
4. Definir público e região.
5. Definir regras de exibição.
6. Acompanhar resultados.
7. Controlar o investimento.

O objetivo é transformar publicidade local em **performance mensurável**.

---

## Arquitetura

O projeto utiliza uma organização **feature-based**, mantendo separação entre interface, regras de negócio e infraestrutura. O objetivo é permitir que o MVP evolua para uma plataforma distribuída sem precisar reconstruir o domínio do produto.

```
lib/
├── app/
├── core/
│   ├── location/    ├── map/          ├── mining/
│   ├── networking/  ├── security/     ├── storage/
│   ├── theme/       └── utils/
├── features/
│   ├── auth/        ├── campaigns/    ├── fraud/
│   ├── home/        ├── location/     ├── map_control/
│   ├── market/      ├── merchant/     ├── mining/
│   ├── onboarding/  ├── profile/      └── wallet/
└── shared/
    ├── components/
    └── widgets/
```

### Engines principais

O núcleo já possui componentes dedicados para:

- ciclo de vida das campanhas;
- alocação de campanhas;
- motor de mineração;
- modelos de oportunidade;
- reserva de oportunidade;
- regras de controle do mapa;
- segurança do dispositivo;
- carteira e recompensas.

---

## Estado atual

### MVP implementado

O MVP já possui:

- Splash e identidade SEEK7
- Onboarding
- Autenticação em modo protótipo
- Google Maps
- Pins dourados
- Oportunidades patrocinadas
- Experiência patrocinada de demonstração
- Recompensas e carteira
- Histórico
- Área de negócios
- Publicação de campanhas em modo protótipo
- Controle centralizado de regras do mapa
- Estrutura inicial de antifraude
- Testes do motor de mineração

> O saldo e as campanhas atuais são locais e servem para demonstração. Nenhum pagamento real é processado pelo MVP.

---

## Roadmap

### Fase 1 — MVP
- [x] Interface mobile
- [x] Mapa
- [x] Pins de oportunidades
- [x] Carteira
- [x] Campanhas
- [x] Motor inicial de oportunidades
- [x] Controle centralizado do mapa

### Fase 2 — Plataforma
- [ ] Backend real
- [ ] Banco de dados
- [ ] Autenticação real
- [ ] API de campanhas
- [ ] Vídeos reais
- [ ] Verificação de conclusão
- [ ] Geolocalização avançada
- [ ] Analytics

### Fase 3 — Monetização
- [ ] Checkout para anunciantes
- [ ] Sistema de orçamento
- [ ] Pagamentos
- [ ] Saques
- [ ] KYC/AML
- [ ] Relatórios para empresas

### Fase 4 — Inteligência
- [ ] Matching usuário ↔ oportunidade
- [ ] Personalização baseada em interesses
- [ ] Otimização automática de campanhas
- [ ] Detecção avançada de fraude
- [ ] Predição de demanda
- [ ] Distribuição inteligente de orçamento

---

## Visão

O SEEK7 Gold pode evoluir para uma infraestrutura de **publicidade local orientada por contexto**, na qual o mapa funciona como uma camada dinâmica de oportunidades.

A pergunta central do produto é:

> **Qual oportunidade tem maior valor para esta pessoa, neste lugar, neste momento?**

A partir dessa pergunta, o sistema poderá decidir:

**quem deve ver → onde deve ver → quando deve ver → quanto vale a ação → qual campanha tem maior potencial de conversão.**

---

## Stack

- Flutter / Dart
- Google Maps
- Arquitetura modular por features
- Serviços desacoplados
- Local storage
- Engine de campanhas
- Engine de mineração
- Controle de mapa
- Camada antifraude
- Testes automatizados

---

## Desenvolvimento

Projeto em evolução contínua, com foco em transformar o MVP em uma plataforma pronta para produção.

O código está estruturado para separar experiência, regras de negócio e infraestrutura, permitindo evoluir o produto em quatro frentes: **marketplace, monetização, inteligência e antifraude.**

<p align="center">
  <strong>SEEK7 Gold</strong><br>
  <sub>Find opportunities. Take action. Get rewarded.</sub>
</p>
