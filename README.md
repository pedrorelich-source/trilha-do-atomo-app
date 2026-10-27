# Trilha do Átomo — App (Flutter)

Primeira versão funcional do aplicativo **Trilha do Átomo**, uma experiência educativa e gamificada que mostra as aplicações e os benefícios da tecnologia nuclear no dia a dia.

**Empresa parceira:** Marinha do Brasil — Centro Tecnológico da Marinha em São Paulo (CTMSP) · FIAP Challenge 2026
**Disciplina:** Mobile Application Development — Sprint 1

## Integrantes

| Nome | RM |
|---|---|
| Pedro Relich | RM567933 |
| Luigi Martiins | RM568381 |

Curso: Análise e Desenvolvimento de Sistemas — 2º ano (turmas de agosto) · Turma: **2TDSPA**

## Descrição da solução

A tecnologia nuclear costuma ser associada só a usinas, radiação e uso militar, mas ela já está na saúde, nos alimentos, na agricultura, na indústria e na energia. No app, o usuário percorre uma **trilha de 10 estações**, cada uma uma área de aplicação. Em cada estação ele lê um conteúdo curto **com fonte**, responde a desafios **"Mito ou Verdade"**, recebe a explicação na hora e acumula pontos e níveis. A **Estação ao vivo** mostra leituras de radiação natural do ambiente: é a ponte com a proposta de IoT do projeto.

Nesta Sprint os dados são **mockados**, como permite a disciplina. São os mesmos conteúdos e desafios, com fontes verificadas, que a API Java do projeto grava no Oracle.

## Telas e fluxo de navegação

```
Boas-vindas ──► Cadastro (formulário) ──► Trilha (grade de estações) ──► Estação ──► Desafio Mito ou Verdade
                                               │                            ▲              │ (Dialog com resultado,
                                               ├──► Perfil ──► Sair         └──────────────┘  devolvido à estação)
                                               └──► Estação ao vivo
```

| # | Tela | Finalidade | Destaques técnicos |
|---|---|---|---|
| 1 | **Boas-vindas** | Apresenta a proposta e leva ao cadastro | `Image` (logo), `Row`/`Column`, `Container`, `Spacer` |
| 2 | **Cadastro** | Cria o perfil do participante | `Form` + `GlobalKey<FormState>`, `TextFormField`, `DropdownButtonFormField`, `SwitchListTile`, consentimento LGPD (`CheckboxListTile` validado), `SnackBar` |
| 3 | **Trilha** | Progresso e escolha da estação | `GridView.builder`, `Card`, `LinearProgressIndicator`; recebe o `Usuario` por parâmetro |
| 4 | **Estação** | Conteúdo, benefício e fonte | Recebe `Estacao` e `Usuario` por parâmetro; recebe o resultado do desafio na volta |
| 5 | **Desafio Mito ou Verdade** | Jogo com feedback imediato | **`StatefulWidget` + `setState()`**: placar, resposta e explicação mudam a cada toque; `AlertDialog` com o resultado |
| 6 | **Perfil** | Dados, pontos, % de acerto, nível e conquistas | `ListView`, `CircleAvatar`, `ListTile`; sair com confirmação em `Dialog` |
| 7 | **Estação ao vivo** | Radiação natural do ambiente (proposta IoT) | `setState` com nova leitura, média e histórico; dados simulados e identificados como tal |

Navegação com `Navigator` e `MaterialPageRoute`:
- **avançar e voltar:** `push` e `pop`;
- **passagem de parâmetros:** pelos construtores das telas;
- **retorno de dados:** `pop(resultado)`;
- **depois do cadastro:** `pushReplacement`, para o "voltar" não reabrir o formulário;
- **ao sair:** `pushAndRemoveUntil`.

## Requisitos da Sprint

| Requisito | Onde está |
|---|---|
| Mínimo de 5 telas com navegação funcional | 7 telas (tabela acima) |
| Protótipo visual com identidade consistente | `lib/theme/app_theme.dart`: paleta azul-marinho e âmbar, tipografia e espaçamentos únicos |
| Widgets da disciplina | `Scaffold`, `AppBar`, `Column`, `Row`, `Container`, `Padding`, `SizedBox`, `Card`, `Image`, `Icon`, `ListView`, `GridView` |
| Gerenciamento de estado | `DesafioScreen` (placar e respostas), `EstacaoAoVivoScreen` (leituras), `CadastroScreen` (perfil, switch, checkbox), `TrilhaScreen` (progresso ao voltar) |
| Formulário com validação | `CadastroScreen` + `lib/utils/validadores.dart`, com resposta em `SnackBar` |

## Como executar

**Pré-requisitos:** Flutter 3.47 (stable) ou superior e um emulador Android ou um celular Android com depuração USB.

```bash
git clone <URL-DO-REPOSITORIO-CLASSROOM>
cd trilha-do-atomo-app
flutter pub get
flutter run
```

Com mais de um dispositivo conectado, liste com `flutter devices` e escolha com `flutter run -d <id>`.

**Testes automatizados** (22 testes):
```bash
flutter test
```
Os testes cobrem os validadores do formulário, o fluxo de navegação, a validação com mensagens de erro, o desafio (placar com `setState`, `Dialog` e resultado devolvido), a regra de pontuação, o perfil e a estação ao vivo.

## Tecnologias

- Flutter 3.47 / Dart 3.13
- Material 3 (sem pacotes externos de gerenciamento de estado, só `setState`, como visto em aula)
- flutter_test e flutter_lints

## Estrutura

```
lib/
├── main.dart                 → MaterialApp, tema e tela inicial
├── theme/app_theme.dart      → cores, espaçamentos e tema
├── models/                   → Estacao, Desafio, Usuario, Leitura
├── data/dados_mock.dart      → 10 estações e 13 desafios (dados mockados)
├── utils/validadores.dart    → regras de validação do formulário
├── widgets/estacao_card.dart → cartão de estação da grade
└── screens/                  → as 7 telas
assets/images/logo_atomo.png  → logo
test/                         → testes de unidade e de widget
```

## Vídeo de demonstração

YouTube (não listado): `PENDENTE — inserir o link após publicar`

## Fontes do conteúdo

IAEA (irradiação de alimentos, técnica do inseto estéril, indústria, água), INCA (radioterapia), IEN/CNEN (esterilização), CNEN (Reator Multipropósito Brasileiro), Eletronuclear (Angra 1) e Revista Pesquisa FAPESP (radiofármacos; Labgene).
