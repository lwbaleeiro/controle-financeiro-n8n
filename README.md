# Automação de Controle Financeiro com n8n

Este é um workflow do n8n para automatizar o controle financeiro pessoal.

### 1. Leitura de Emails:
O nó ```readEmails``` busca emails na sua caixa de entrada (Inbox) com o remetente, que provavelmente contém extratos bancários ou informações de transações.
Os anexos desses emails são baixados e armazenados na variável ```attachment_2```.

### 2. Extração de Dados:
O nó ```Extract from File``` extrai os dados do arquivo anexado (attachment_2), que deve estar em um formato como CSV ou Excel.
Os dados extraídos são convertidos para JSON e armazenados em variáveis como Data, Valor, Identificador e Descrição.

### 3. Registro das Transações:
O nó ```Google Sheets``` adiciona ou atualiza as transações em uma planilha do Google Sheets, usando o ID da transação como chave.
As colunas DATA, VALOR, ID e DESCRIÇÃO são mapeadas para as colunas correspondentes na planilha.

### 4. Categorização Automática:
O nó ```getAllTransactions``` busca todas as transações da planilha.
O nó ```hasEmptyCategory``` verifica se há transações sem categoria.
Se houver transações sem categoria:
O nó ```getEmptyCategoryData``` busca os dados dessas transações.
O nó ```hasMatchDescription``` verifica se há transações com descrições similares que já possuem categorias.
Se houver correspondência, o nó ```getCategoryToUpdate``` sugere a categoria mais frequente para a descrição.
O nó ```updateEmptyCategory``` atualiza a planilha com as categorias sugeridas.

### 5. Armazenamento em Banco de Dados:
O nó ```getAllTransactionsUpdated``` busca todas as transações atualizadas da planilha.
O nó ```formattedData``` formata a data das transações para o formato ```YYYY/MM/DD```.
O nó ```upsertTransactions``` adiciona ou atualiza as transações em um banco de dados PostgreSQL, usando o ID da transação como chave.

### 6. Geração de Relatório:
O nó ```AI Agent``` usa um modelo de linguagem (Google Gemini) para gerar um relatório financeiro com base nas transações do banco de dados.
O relatório inclui um resumo do mês atual, comparação com o mês anterior, receitas, despesas, agrupamento por categorias, variações de gastos e insights financeiros.
O nó ```Code``` formata o relatório para exibição no Telegram.
O nó ```Telegram``` envia o relatório formatado para o seu chat do Telegram.
Observações:
O nó ```setEmailAsProcessed``` está desabilitado, mas pode ser usado para marcar os emails processados no Gmail.

O workflow está configurado para ser executado manualmente, mas pode ser agendado para rodar automaticamente.
As credenciais para acessar o Gmail, Google Sheets, PostgreSQL e Telegram devem ser configuradas nos nós correspondentes.

--------------------
Este é um exemplo de como automatizar o controle financeiro pessoal com o n8n. Você pode personalizar o workflow de acordo com suas necessidades, adicionando ou removendo nós, alterando parâmetros e integrando com outros serviços.