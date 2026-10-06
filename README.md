# SEEK7 Gold

<p align="center">
  <strong>Encontre. Faça. Ganhe.</strong><br>
  Transforme o mapa da cidade em um mercado inteligente de oportunidades.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Status-MVP-FFD21F" alt="MVP">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-111827" alt="Platforms">
</p>

---

## Produto

O SEEK7 Gold conecta **pessoas, negócios e localização** em uma única experiência.

O mapa deixa de ser apenas uma ferramenta de navegação e passa a mostrar **oportunidades patrocinadas próximas**, representadas por pins dourados.

> **Negócio precisa de atenção → SEEK7 encontra pessoas relevantes → pessoa interage → negócio paga pela ação → usuário recebe recompensa.**

---

## Experiência do app

### Descobrir → Escolher → Interagir → Ganhar

<div align="center">
  <img src="https://github.com/user-attachments/assets/59453c01-abef-448d-8486-796e8ae70288" alt="SEEK7 Gold — tela do aplicativo" width="300">
</div>

<p align="center"><sub>Prévia da experiência SEEK7 Gold</sub></p>

> As telas reais do aplicativo serão apresentadas nesta seção conforme os screenshots forem adicionados ao repositório.

---

## Como funciona

| Etapa | O que acontece |
|---|---|
| **01 — Descobrir** | O usuário abre o mapa e encontra oportunidades próximas. |
| **02 — Escolher** | Cada pin dourado representa uma oportunidade disponível. |
| **03 — Interagir** | O usuário abre a oportunidade e executa a ação patrocinada. |
| **04 — Ganhar** | Após a conclusão válida, a recompensa é registrada na carteira. |
| **05 — Repetir** | O mapa é atualizado conforme novas oportunidades aparecem. |

---

## O diferencial

O SEEK7 não foi pensado como mais uma plataforma tradicional de anúncios. A ideia é criar um **mercado geográfico de atenção**.

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

O projeto está organizado por domínio/feature, mantendo separação entre interface, regras de negócio e infraestrutura.

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

### Engine de oportunidades

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

O MVP possui:

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

Em vez de simplesmente mostrar anúncios, o sistema decide:

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

Projeto em evolução contínua, com foco em transformar o MVP em uma arquitetura pronta para produção, mantendo uma experiência simples para o usuário e um motor sofisticado de decisão.

<p align="center">
  <strong>SEEK7 Gold</strong><br>
  <sub>Find opportunities. Take action. Get rewarded.</sub>
</p>
