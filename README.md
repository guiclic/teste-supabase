# Sistema de Gestão de Clientes

Um aplicativo web para gerenciar clientes, construído com Python (Flask) e Supabase para persistência de dados.

## Funcionalidades

- Lista de clientes em status "Em aberto"
- Detalhes do cliente com formulário para edição
- Atualização de status (Em aberto, Concluído, Cancelado)
- Validação de formulários
- Modo quiosque (tela cheia)

## Estrutura do Banco de Dados

Tabela `clientes`:
- id (UUID, chave primária)
- nome (VARCHAR)
- telefone (VARCHAR)
- endereco (TEXT)
- email (VARCHAR, único)
- plano (VARCHAR)
- id_fly (VARCHAR)
- status (ENUM: Em aberto, Concluido, Cancelado)
- observacoes (TEXT)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

## Tecnologias Utilizadas

- Backend: Python, Flask
- Frontend: HTML, CSS, JavaScript
- Banco de Dados: PostgreSQL (via Supabase)
- ORM: Supabase Python Client

## Como Instalar

1. Clone o repositório
2. Instale as dependências:
   ```
   pip install -r requirements.txt
   ```

## Como Executar

1. Execute o aplicativo:
   ```
   python app.py
   ```
2. Acesse em seu navegador:
   ```
   http://localhost:5000
   ```
3. Para modo quiosque, clique no botão "Entrar em Modo Quiosque"

## Requisitos

- Python 3.8+
- Conexão com internet (para acesso ao Supabase) 