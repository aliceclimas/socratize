<section align="center">
  <img width="100%" align="center" src="https://github.com/user-attachments/assets/71ada8f1-b8ec-4434-894b-d365f2a59686"/>
  
  <br/>
  <br/>
  
  <blockquote>
    Você tem certeza... ou não se questionou ainda?
  </blockquote>
</section>

<br/>

<section align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt='Flutter' />
  <img src="https://img.shields.io/badge/Firebase-000?style=for-the-badge&logo=firebase&logoColor=ffca28" alt='Firebase' />
  <img src="https://img.shields.io/badge/Git-F05032?logo=git&logoColor=fff&style=for-the-badge" alt='Git' />
  <img src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white" alt='VSCode' />
  <img src="https://img.shields.io/badge/Figma-696969?style=for-the-badge&logo=figma&logoColor=figma" alt='Figma' />
</section>

<h2 align="center">Estrutura do Projeto</h2>

# Socratize

**Socratize** é um aplicativo voltado para o uso clínico por psicólogos, com foco no processo de **questionamento socrático** de pensamentos disfuncionais. Ele simula uma interface de conversa interativa para guiar o paciente por etapas reflexivas baseadas na Terapia Cognitivo-Comportamental (TCC).

**Link do Repositório:** [https://github.com/aliceclimas/socratize](https://github.com/aliceclimas/socratize)

## Sumário

1.  [Visão Geral do Aplicativo](#visão-geral-do-aplicativo)
2.  [Distribuição e Acesso](#distribuição-e-acesso)
    *   [Tipos de Usuários](#tipos-de-usuários)
        *   [Psicólogos](#psicólogos)
        *   [Pacientes](#pacientes)
3.  [Funcionamento do Questionamento Socrático](#funcionamento-do-questionamento-socrático)
    *   [Etapas do Processo](#etapas-do-processo)
    *   [Classificação por Disfunção Cognitiva](#classificação-por-disfunção-cognitiva)
4.  [Estrutura de Dados no Firebase](#estrutura-de-dados-no-firebase)
    *   [Collection `Pergunta`](#collection-pergunta)
    *   [Collection `DisfuncaoCognitiva`](#collection-disfuncaocognitiva)
    *   [Documentos de `Questionamento`](#documentos-de-questionamento)
5.  [Exemplos de Uso](#exemplos-de-uso)
6.  [Considerações Finais](#considerações-finais)

---

## Visão Geral do Aplicativo

**Socratize** é um aplicativo projetado para ser uma ferramenta digital de apoio a psicólogos que utilizam a Terapia Cognitivo-Comportamental (TCC). Seu principal objetivo é facilitar o processo de **questionamento socrático**, ajudando pacientes a identificar, analisar e reestruturar pensamentos disfuncionais. Através de uma interface de chat interativa, o aplicativo guia o usuário por uma série de etapas reflexivas, promovendo a autoconsciência e a mudança cognitiva.

---

## Distribuição e Acesso

O Socratize **não será distribuído por lojas de aplicativos convencionais** (como Google Play ou Apple Store) para garantir o uso adequado e supervisionado. A distribuição e o acesso são controlados e variam conforme o tipo de usuário.

### Tipos de Usuários
O sistema Socratize define dois tipos principais de usuários: `Psicólogos` e `Pacientes`.

#### Psicólogos

*   **Solicitação:** Interessados devem solicitar o aplicativo através do **site oficial** do Socratize.
*   **Validação:** É necessário preencher um formulário com dados que comprovem a formação e habilitação profissional (e.g., registro no conselho de psicologia).
*   **Entrega:** Após a validação, o aplicativo é enviado diretamente ao psicólogo.
*   **Funcionalidades:**
    *   Cadastrar pacientes.
    *   Gerenciar o acesso dos seus pacientes.
    *   Distribuir o aplicativo individualmente para os pacientes sob seus cuidados.
*   **Exemplo de Representação no Banco de Dados:**
    ```dart
    {
      "idPsicologo": "psiUnico123",
      "nomeCompleto": "Dr. Nome Exemplo",
      "email": "dr.exemplo@socratize.com",
      "crp": "CRP-00/00000",
      "pacientesIds": ["pacienteA456", "pacienteB789"]
    }
    ```

#### Pacientes

*   **Acesso Restrito:** O aplicativo **não é acessível ao público geral**. O acesso é concedido exclusivamente por um psicólogo cadastrado.
*   **Cadastro:** O psicólogo realiza o cadastro do paciente, informando:
    *   Nome completo;
    *   E-mail;
    *   Senha provisória.
*   **Primeiro Acesso (Ativação em Sessão):**
    *   O psicólogo gera um **QR Code** único para o paciente.
    *   O paciente escaneia o QR Code durante uma sessão terapêutica para ativar sua conta.
*   **Acesso Pós-Ativação:**
    *   Login é feito via e-mail e a senha definida pelo paciente.
    *   O QR Code não é mais necessário para logins subsequentes, a menos que a conta seja desativada.
*   **Reativação de Conta:**
    *   Caso a conta seja desativada, um novo escaneamento de QR Code (o mesmo original, se ainda válido, ou um novo gerado pelo psicólogo) será necessário.
*   **Exemplo de Representação no Banco de Dados:**
    ```dart
    {
      "idPaciente": "pacienteA456",
      "nomeCompleto": "Nome Completo do Paciente",
      "email": "paciente.exemplo@email.com",
      "idPsicologoAssociado": "psiUnico123",
      "contaAtiva": true,
    }
    ```

---

## Funcionamento do Questionamento Socrático

O núcleo do Socratize é um **chat interativo** que simula o diálogo socrático. Este processo guia o paciente a refletir criticamente sobre um pensamento automático disfuncional.

### Etapas do Processo

1.  **Identificação do Pensamento:**
    *   O paciente é convidado a descrever um pensamento automático negativo ou angustiante que vivenciou.
2.  **Seleção de Perguntas Socráticas:**
    *   O aplicativo apresenta perguntas socráticas agrupadas por **categorias temáticas**.
    *   Para cada categoria, o paciente escolhe **uma pergunta** que considera mais relevante para seu pensamento e registra sua resposta.
    *   **Categorias e seus Objetivos:**

        | Categoria                   | Objetivo                                                                          |
        |-----------------------------|-----------------------------------------------------------------------------------|
        | Esclarecimento              | Explorar suposições, significados e detalhes implícitos no pensamento.            |
        | Desafio de Suposições       | Questionar crenças subjacentes, regras pessoais ou premissas não examinadas.      |
        | Evidências                  | Buscar fatos concretos que sustentam ou contradizem o pensamento inicial.         |
        | Pontos de Vista Alternativos | Considerar outras interpretações ou perspectivas para a situação ou o pensamento. |

### Classificação por Disfunção Cognitiva

*   Após o paciente registrar seu pensamento inicial, uma **Inteligência Artificial (IA)** analisa o texto.
*   A IA identifica e classifica a(s) **disfunção(ões) cognitiva(s)** predominante(s) com base no conteúdo fornecido.
*   Esta classificação pode ajudar o paciente e o psicólogo a entenderem padrões de pensamento.
*   **Classificações Possíveis (Exemplos):**

    | Nº | Disfunção Cognitiva             | Descrição Breve                                 |
    | -- | ------------------------------- | ----------------------------------------------- |
    | 1  | **Personalização**              | Responsabilizar-se por eventos fora de controle |
    | 2  | **Filtro Mental**               | Focar apenas no negativo, ignorando o positivo  |
    | 3  | **Generalização Excessiva**     | Conclusões amplas a partir de eventos isolados  |
    | 4  | **Catastrofização**             | Suposição de cenários extremos ou desastrosos   |
    | 5  | **Pensamento Dicotômico**       | Ver tudo como "8 ou 80", sem nuances            |
    | 6  | **Leitura da Mente**            | Presumir o que outros pensam sem evidências     |
    | 7  | **Raciocínio Emocional**        | Considerar emoções como fatos objetivos         |
    | 8  | **Desqualificação do Positivo** | Minimizar realizações e feedbacks positivos     |
    | 9  | **Uso de "Deveria"**            | Expectativas rígidas sobre si, outros ou o mundo |

---

## Estrutura de Dados no Firebase

O backend do Socratize utiliza o Firebase. A seguir, a estrutura dos principais documentos (collections) armazenados:

### Collection `Pergunta`
Armazena as perguntas socráticas utilizadas no chat.

```dart
{
  "idPergunta": "p1", // ID único da pergunta
  "texto": "Qual a evidência de que isso vai acontecer?",
  "categoria": "evidencias" // e.g., esclarecimento, evidencias, etc.
}
```

### Collection `DisfuncaoCognitiva`
Catálogo das disfunções cognitivas que a IA pode identificar.

```dart
{
  "idDisfuncao": "catastrofizacao", // ID único da disfunção
  "titulo": "Catastrofização",
  "descricao": "Você espera que o pior aconteça, mesmo quando há poucas ou nenhuma evidência de que isso vá ocorrer. Frequentemente assume cenários catastróficos sem considerar outras possibilidades.",
  "exemplo": "Se eu errar uma palavra na apresentação, todos vão achar que sou incompetente."
}
```
Esta collection contém um documento para cada uma das disfunções listadas na seção de Classificação por Disfunção Cognitiva.

### Documentos de `Questionamento`
Registra cada sessão de questionamento socrático realizada pelo paciente.

```dart
{
  "idQuestionamento": "qstUnicoXYZ", // ID único do questionamento
  "idPaciente": "pacienteA456",
  "titulo": "Apresentação no trabalho", // Definido pelo paciente
  "pensamentoInicial": "Acho que vou falhar na apresentação",
  "idDisfuncaoCognitiva": "catastrofizacao", // ID da collection DisfuncaoCognitiva
  "dataCriacao": "2025-05-09T10:00:00Z",
  "respostas": [
    {
      "idPergunta": "p1", // Referência à collection Pergunta
      "respostaPaciente": "Nenhuma clara, só estou inseguro",
    },
    {
      "idPergunta": "p3",
      "respostaPaciente": "Que ele se preparou bem e deveria confiar mais em si.",
    }
  ],
  "pensamentoReavaliado": "Posso estar exagerando o risco. Tenho algumas inseguranças, mas também me preparei.", // Pensamento final após a reflexão
}
```

---

## Exemplos de Uso

O Socratize pode ser utilizado de diversas formas no contexto terapêutico:

*   **Ferramenta de Apoio em Sessões:** Utilizado durante as sessões de TCC para guiar o diálogo socrático.
*   **Recurso de "Dever de Casa":** Designado como tarefa entre as sessões para que o paciente pratique a reflexão.
*   **Diário Reflexivo Digital:** Um espaço para o paciente registrar e analisar pensamentos disfuncionais recorrentes.
*   **Histórico Pessoal:** Permite ao paciente e ao terapeuta acompanhar o progresso, identificar padrões de distorções cognitivas e a evolução do pensamento.

---

## Considerações Finais

O Socratize visa ser uma ferramenta complementar valiosa no processo terapêutico, digitalizando e estruturando o questionamento socrático. Seu design foca em:

*   **Acessibilidade:** Facilitar o acesso a técnicas da TCC.
*   **Estrutura Guiada:** Oferecer um caminho claro para a reflexão.
*   **Registro Terapêutico:** Manter um histórico do trabalho realizado.

É crucial ressaltar que o Socratize **deve ser utilizado sob a mediação de um profissional de psicologia habilitado**. Isso garante a segurança do paciente, o acompanhamento adequado e a manutenção da ética clínica. A integração com IA para classificação de disfunções busca enriquecer o processo, oferecendo insights adicionais tanto para o paciente quanto para o terapeuta, mas não substitui o julgamento clínico profissional.

---
