# Task App Sync 📋

Aplicação Rails Full Stack para sincronização de tarefas com API externa.

![Rails](https://img.shields.io/badge/Rails-8.1.2-red)
![Ruby](https://img.shields.io/badge/Ruby-3.3.4-red)
![Tests](https://img.shields.io/badge/Tests-18%20passing-green)
![Docker](https://img.shields.io/badge/Docker-Ready-blue)

## 📖 Sobre o Projeto

Sistema web de gerenciamento de tarefas com sincronização de dados de usuários externos via API REST. Desenvolvido com Rails 8, Stimulus.js e TailwindCSS/Flowbite.

### Funcionalidades

- ✅ Tela única exibindo uma tarefa
- ✅ Botão "Sincronizar usuário" que busca dados da API externa
- ✅ Atualização sem reload da página (Stimulus + Fetch API)
- ✅ Seleção dinâmica de ID do usuário (1-10)
- ✅ Mensagens de feedback (sucesso/erro)
- ✅ Animações de loading
- ✅ Design responsivo com Flowbite
- ✅ Testes completos com RSpec (18 testes)

## 🛠 Tecnologias

### Backend
- **Ruby** 3.3.4
- **Rails** 8.1.2
- **SQLite3** - Banco de dados
- **HTTParty** - Cliente HTTP para API externa

### Frontend
- **Stimulus.js** - JavaScript framework
- **TailwindCSS** - Estilização
- **Flowbite** - Componentes UI
- **ViewComponent** - Componentes reutilizáveis

### Testes
- **RSpec** - Framework de testes
- **FactoryBot** - Factories para testes
- **Faker** - Dados dinâmicos
- **WebMock** - Mock de requisições HTTP
- **Shoulda Matchers** - Matchers para validações

## 🚀 Instalação

### Opção 1: Sem Docker

Requisitos:
- Ruby 3.3.4
- Node.js
- SQLite3

```bash
# Clonar repositório
git clone <seu-repo>
cd task-app-sync

# Instalar dependências
bundle install

# Configurar banco
rails db:create
rails db:migrate

# Iniciar servidor
bin/dev
```

Acesse: http://localhost:3000

### Opção 2: Com Docker (Recomendado)

Requisitos:
- Docker
- Docker Compose
- Make (opcional)

```bash
# Setup completo
make setup

# Iniciar aplicação
make up
```

Acesse: http://localhost:3000

## 🧪 Testes

### Sem Docker

```bash
# Executar todos os testes
bundle exec rspec

# Com formatação detalhada
bundle exec rspec --format documentation
```

### Com Docker

```bash
# Executar todos os testes
make test

# Com formatação detalhada
make rspec
```

### Cobertura de Testes

```
18 examples, 0 failures

- 9 testes do modelo Task
- 6 testes do controller TasksController
- 3 testes do serviço UserSyncService
```


## 🐳 Comandos Docker

```bash
make help          # Ver todos os comandos
make setup         # Setup inicial
make up            # Iniciar aplicação
make test          # Executar testes
make rspec         # RSpec formatado
```

## 📁 Estrutura do Projeto

```
task-app-sync/
├── app/
│   ├── components/          # ViewComponents
│   ├── controllers/         # Controllers
│   ├── models/             # Models
│   ├── services/           # Service Objects
│   ├── javascript/         # Stimulus controllers
│   └── views/              # Views
├── spec/                   # Testes RSpec
├── docker-compose.yml      # Docker Compose
├── Dockerfile.dev          # Dockerfile desenvolvimento
└── Makefile               # Comandos facilitados
```

---

⭐ **Documentação completa disponível em [SETUP.md](SETUP.md)**
