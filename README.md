# Secure Task Manager
Secure Task Manager é um website simples para gerenciar suas tarefas e seus status, mas sem perder segurança.

O projeto implementa boas práticas de segurança com autenticação utilizando token JWT.

## Tecnologias
**Back-end**
  - NodeJS
  - TypeScript
  - TypeORM
  - Fastify
  - Autenticação JWT (JSON Web Token)
  - dotenv
  - Crypto (para hash da senha)
  - Docker
  - PostgresSQL

**Front-end**
  - Flutter
  - Shared Preferences
  - flutter_dotenv
  - Go Router
  - DIO (Client http)
  - Riverpod (Gerenciamento de estado)

## Arquitetura / System Design
[**Diagramas**](./docs/system-design)

```
.github/ # Diretório contendo configurações de pipelines do GitHub Actions
└── workflows/
    └── build_web.yml

backend/  # Diretório principal do backend
├── migrations/   # Diretório que contém as migrations
├── src/    # Código-fonte do backend.
    ├── config/   # Arquivos de configuração
        ├── db_data_source.ts   # Configuração do DataSource do TypeORM, onde é configurada a conexão do banco de dados, entidades e outras configurações do TypeORM
        └── environment_config.ts   # Configuração para pegar as variáveis de ambiente do projeto
    ├── controllers/    # Diretório de Controllers, responsáveis por gerenciar as requisições recebidas pelas rotas da API. Eles utilizam as entidades e repositórios do TypeORM para realizar operações no banco de dados e retornam as respostas apropriadas
        ├── auth_controller.ts    # Gerencia a autenticação e autorização, incluindo login e renovação de tokens.
        ├── task_controller.ts    # Lida com operações relacionadas às tarefas, como criação, leitura, atualização e exclusão.
        ├── task_status_controller.ts     # Gerencia os status das tarefas, permitindo criar, listar, atualizar e excluir status.
        └── user_controller.ts    # Responsável por operações relacionadas aos usuários, como criação de novos usuários.
    ├── entities/   # Representam modelos dos dados do sitema, ligados ao banco de dados utilizando o TypeORM. Cada entidade define os campos, tipos e relacionamentos necessários.
        ├── task_status.ts    # Entidade que representa status das tarefas, como "pendente" ou "em andamento".
        ├── task.ts   # Entidade que representa as tarefas, com informações como: título e descrição.
        └── user.ts   # Entidade que representa os usuários do sistema, incluindo informações de nome de usuário, senha (armazenada como hash MD5).
    ├── middlewares/    # Funções intermediárias que são executadas antes ou depois das rotas. Eles são usados para adicionar autenticação ou validação.
        └── auth_middleware.ts    # Responsável por verificar se o usuário está autenticado, validando o token JWT presente no cabeçalho da requisição.
    ├── models/   # Estruturas auxiliares que definem tipos e interfaces para dados que não estão diretamente associados às entidades do banco de dados;
        ├── jwt_payload.ts    # Define o formato do playload do token JWT.
        └── user_tokens.ts    # Representa os tokens de autenticação (access token e refresh token)
    ├── routes.ts   # Responsável por definir todas as rotas da API
    └── server.ts   # Responsável por inicializar o servidor Fastify e configurar os principais aspectos da aplicação, como CORS, rotas, Loggers, etc.
├── .env.example    # Arquivo de exemplo para configuração da .env
├── .env    # Arquivo com variáveis de ambiente do sistema
├── docker-compose.db.mysql   # Arquivo de configuração para rodar um docker com MySQL
├── docker-compose.db.postgres.yml    # Arquivo de configuração para rodar um docker com Postgres
├── package.json    # Arquivo de configuração do projeto, com configurações para dependências e scripts
└── tsconfig.json   # Arquivo de configuração do TypeScript

frontend/  # Diretório principal do frontend
├── lib/  # Contém o código principal do aplicativo Flutter
    ├── core/  # Configurações e utilitários globais do projeto
        ├── config/
            └── environment_config.dart  # Configuração para acessar variáveis de ambiente no Flutter
        └── utils/
            └── size_utils.dart  # Funções auxiliares para lidar com tamanhos e dimensões na interface
    ├── features/  # Funcionalidades principais do aplicativo
        ├── auth/  # Gerenciamento de autenticação
            ├── data/  # Implementações relacionadas a dados, como repositórios e interceptors
                ├── interceptors/
                    └── auth_interceptor.dart  # Intercepta requisições para adicionar tokens de autenticação
                ├── providers/
                    └── auth_repository_providers.dart  # Fornece instâncias de repositórios de autenticação
                └── repositories/
                    ├── auth_repository_impl.dart  # Implementação do repositório de autenticação
                    └── auth_tokens_repository_impl.dart  # Implementação do repositório de tokens de autenticação
            ├── domain/  # Modelos, serviços e interfaces relacionados à autenticação
                ├── models/
                    └── user_tokens_model.dart  # Modelo para representar tokens de usuário
                ├── providers/
                    └── auth_service_providers.dart  # Fornece instâncias de serviços de autenticação
                ├── repositories/
                    ├── auth_repository.dart  # Interface para o repositório de autenticação
                    └── auth_tokens_repository.dart  # Interface para o repositório de tokens de autenticação
                └── services/
                    └── auth_service.dart  # Serviço para lidar com lógica de autenticação
            ├── exceptions/  # Exceções específicas para autenticação
                ├── login_exception.dart  # Exceção para erros de login
                └── refresh_token_exception.dart  # Exceção para erros ao renovar tokens
            ├── presentation/  # Camada de apresentação (UI e controladores)
                └── views/
                    └── login_screen/  # Tela de login
                        ├── controller/
                            ├── login_controller.dart  # Controlador para gerenciar a lógica da tela de login
                            └── login_state.dart  # Estado gerenciado pelo controlador de login
                        └── login_screen.dart  # Interface da tela de login
            └── routes/
                └── auth_routes.dart  # Definição de rotas relacionadas à autenticação
        ├── task/  # Funcionalidades relacionadas às tarefas
            ├── data/  # Implementações relacionadas a dados de tarefas
                └── repositories/
                    └── task_repository_impl.dart  # Implementação do repositório de tarefas
            ├── domain/  # Modelos, serviços e interfaces relacionados às tarefas
                ├── models/
                    └── task_model.dart  # Modelo para representar uma tarefa
                ├── repositories/
                    └── task_repository.dart  # Interface para o repositório de tarefas
                └── services/
                    └── task_service.dart  # Serviço para lidar com lógica de tarefas
            ├── exceptions/  # Exceções específicas para tarefas
                ├── create_task_exception.dart  # Exceção para erros ao criar tarefas
                ├── delete_task_exception.dart  # Exceção para erros ao deletar tarefas
                ├── get_task_exception.dart  # Exceção para erros ao obter tarefas
                └── update_task_exception.dart  # Exceção para erros ao atualizar tarefas
            ├── presentation/  # Camada de apresentação (UI e controladores)
                ├── views/
                    ├── create_task_modal/  # Modal para criar tarefas
                        ├── controllers/
                            ├── create_task_controller.dart  # Controlador para criar tarefas
                            ├── create_task_state.dart  # Estado gerenciado pelo controlador de criação de tarefas
                            └── task_status_provider.dart  # Fornece status de tarefas
                        └── create_task_modal.dart  # Interface do modal de criação de tarefas
                    ├── edit_task_modal/  # Modal para editar tarefas
                        ├── controllers/
                            ├── edit_task_controller.dart  # Controlador para editar tarefas
                            └── edit_task_state.dart  # Estado gerenciado pelo controlador de edição de tarefas
                        └── edit_task_modal.dart  # Interface do modal de edição de tarefas
                    └── user_tasks_screen/  # Tela para exibir tarefas do usuário
                        ├── controllers/
                            └── user_tasks_controller.dart  # Controlador para gerenciar tarefas do usuário
                        └── user_tasks_screen.dart  # Interface da tela de tarefas do usuário
                └── widgets/  # Componentes reutilizáveis relacionados às tarefas
                    ├── session_expired_snack_bar.dart  # Snack bar para sessão expirada
                    └── task_item.dart  # Componente para exibir itens de tarefas
            └── providers/
                └── task_providers.dart  # Fornece instâncias relacionadas às tarefas
        ├── task_status/  # Funcionalidades relacionadas ao status das tarefas
            ├── data/  # Implementações relacionadas a dados de status de tarefas
                └── repositories/
                    └── task_status_repository_impl.dart  # Implementação do repositório de status de tarefas
            ├── domain/  # Modelos, serviços e interfaces relacionados ao status de tarefas
                ├── models/
                    └── task_status.dart  # Modelo para representar status de tarefas
                ├── repositories/
                    └── task_status_repository.dart  # Interface para o repositório de status de tarefas
                └── services/
                    └── task_status_service.dart  # Serviço para lidar com lógica de status de tarefas
            ├── exceptions/  # Exceções específicas para status de tarefas
                ├── create_task_status_exception.dart  # Exceção para erros ao criar status de tarefas
                ├── delete_task_status_exception.dart  # Exceção para erros ao deletar status de tarefas
                ├── get_task_status_exception.dart  # Exceção para erros ao obter status de tarefas
                └── update_task_status_exception.dart  # Exceção para erros ao atualizar status de tarefas
            ├── presentation/  # Camada de apresentação (UI e controladores)
                ├── views/
                    ├── create_task_status/  # Modal para criar status de tarefas
                        ├── controllers/
                            └── create_task_status_controller.dart  # Controlador para criar status de tarefas
                        └── create_task_status_modal.dart  # Interface do modal de criação de status de tarefas
                    ├── edit_task_status/  # Modal para editar status de tarefas
                        ├── controllers/
                            ├── edit_task_status_controller.dart  # Controlador para editar status de tarefas
                            └── edit_task_status_state.dart  # Estado gerenciado pelo controlador de edição de status de tarefas
                        └── edit_task_status_screen.dart  # Interface do modal de edição de status de tarefas
                    ├── task_status_settings/  # Tela de configurações de status de tarefas
                        ├── controllers/
                            ├── sign_out_controller.dart  # Controlador para gerenciar logout
                            ├── sign_out_state.dart  # Estado gerenciado pelo controlador de logout
                            ├── task_status_settings_controller.dart  # Controlador para configurações de status de tarefas
                            └── task_status_settings_state.dart  # Estado gerenciado pelo controlador de configurações de status de tarefas
                        └── task_status_settings_screen.dart  # Interface da tela de configurações de status de tarefas
                    └── task_status_settings_screen.dart  # Tela de configurações de status de tarefas
                └── widgets/  # Componentes reutilizáveis relacionados ao status de tarefas
                    └── task_status/
                        ├── controllers/
                            ├── delete_task_controller.dart  # Controlador para deletar status de tarefas
                            └── delete_task_state.dart  # Estado gerenciado pelo controlador de deleção de status de tarefas
                        └── task_status_widget.dart  # Componente para exibir status de tarefas
            └── providers/
                └── task_status_providers.dart  # Fornece instâncias relacionadas ao status de tarefas
        └── user/  # Funcionalidades relacionadas aos usuários
            ├── data/  # Implementações relacionadas a dados de usuários
                └── repositories/
                    └── user_repository_impl.dart  # Implementação do repositório de usuários
            ├── domain/  # Modelos, serviços e interfaces relacionados aos usuários
                ├── models/
                    └── user_model.dart  # Modelo para representar um usuário
                ├── repositories/
                    └── user_repository.dart  # Interface para o repositório de usuários
                └── services/
                    └── user_service.dart  # Serviço para lidar com lógica de usuários
            ├── exception/  # Exceções específicas para usuários
                └── create_account_exception.dart  # Exceção para erros ao criar conta
            ├── presentation/  # Camada de apresentação (UI e controladores)
                └── views/
                    └── create_account_screen/  # Tela de criação de conta
                        ├── controller/
                            ├── create_account_controller.dart  # Controlador para criar conta
                            └── create_account_state.dart  # Estado gerenciado pelo controlador de criação de conta
                        └── create_account_screen.dart  # Interface da tela de criação de conta
            ├── providers/  # Fornecedores de instâncias relacionadas aos usuários
                ├── user_repository_providers.dart  # Fornece instâncias de repositórios de usuários
                └── user_service_providers.dart  # Fornece instâncias de serviços de usuários
            └── routes/
                └── user_routes.dart  # Definição de rotas relacionadas aos usuários
    ├── routes/
        └── app_router.dart  # Configuração de rotas principais do aplicativo
    ├── shared/  # Componentes e serviços compartilhados
        ├── controllers/
            ├── auth_guard_controller.dart  # Controlador para proteger rotas com autenticação
            └── auth_guard_state.dart  # Estado gerenciado pelo controlador de proteção de rotas
        └── providers/
            ├── http_client_provider.dart  # Fornece instância do cliente HTTP
            ├── providers_initializer.dart  # Inicializa os provedores do aplicativo
            └── shared_preferences_provider.dart  # Fornece instância do SharedPreferences
    ├── theme/  # Configuração de temas do aplicativo
        └── app_theme.dart  # Tema principal do aplicativo
    └── main.dart  # Arquivo principal do aplicativo Flutter
├── web/  # Arquivos relacionados à versão web do aplicativo
    ├── icons/  # Ícones utilizados na versão web
        ├── Icon-192.png  # Ícone de 192px
        ├── Icon-512.png  # Ícone de 512px
        ├── Icon-maskable-192.png  # Ícone mascarável de 192px
        └── Icon-maskable-512.png  # Ícone mascarável de 512px
    ├── favicon.png  # Favicon do aplicativo
    ├── index.html  # Arquivo HTML principal da versão web
    └── manifest.json  # Manifesto da aplicação web
├── .env.example    # Arquivo de exemplo para configuração da .env
├── .env    # Arquivo com variáveis de ambiente do sistema
├── .gitignore    # Arquivo de configuiração para o GIT ignorar arquivos e pastas do repositório.
├── analysis_options.yaml   # Configurações de análise estática e regras de lint do Dart
├── pubspec.yaml            # Configuração do projeto Flutter: dependências, assets, versões, etc.
```

## Variáveis de Ambiente
As variáveis de ambiente do frontend estão definidas em [frontend/.env.example](./frontend/.env.example).
As variáveis de ambiente do backend estão definidas em [backend/.env.example](./backend/.env.example).

## Como executar

### Back-end
Requisitos:
- NodeJS
- Opcional: Docker (caso queira rodar os containers dos bancos)

1- Acesse o diretório /backend

2- Execute ```npm install``` no terminal

3- Crie uma .env na raíz do projeto (/backend)

4- Insira as variáveis de ambiente para acesso ao seu Postgres

5- Crie um SECRET para o JWT e insira nas variáveis de ambiente (Pode ser um texto em [base64](https://www.base64encode.org/))

6- Crie um REFRESH_SECRET para o JWT e insira nas variáveis de ambiente (Pode ser um texto em [base64](https://www.base64encode.org/))

7- Insira o endereço para o frontend nas variáveis de ambiente (ou insira "*" para qualquer endereço conseguir acessar a API)

8- Rode ```npm run start:prod``` para gerar as migrations, os arquivos de build e rodar o projeto.

### Front-end
Requisitos:
- Flutter
- Chrome

1- Acesse o diretório /frontend

2- Rode ```flutter pub get```

3- Crie uma .env na raíz do projeto (/frontend)

4- Insira o endereço do seu backend na variável **API_URL**

5- Rode o projeto com flutter run -d chrome --release

## Usuários de Teste
**Login**: __teste__

**Senha**: __teste123__

## Fluxos
### Login
<img width="597" height="459" alt="Image" src="https://github.com/user-attachments/assets/bfbb64cf-2f2c-4dd3-9b7e-b5daa4711185" />

#### Fluxo: Credenciais incorretas
Quando as credenciais do usuário estão incorretas, seja a senha ou o username, o sistema mostra a mensagem "Your username or password is incorrect".
<img width="714" height="519" alt="Image" src="https://github.com/user-attachments/assets/07d9da51-6df9-4725-b46c-0ec4d4b0e7d2" />

### Criação de conta
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/c6d7b46b-4354-4b35-8e58-af352d54432f" />

#### Fluxo: Conta criada com sucesso
Quando há a criação de conta com sucesso, o sistema mostra uma mensagem e redireciona o usuário para a tela de Login.
<img width="1917" height="1079" alt="Image" src="https://github.com/user-attachments/assets/a567ab18-1a18-4d2c-9314-c31403cd4be2" />

#### Fluxo: Conta já existente
Quando há uma conta com o mesmo username, o sistema mostra a mensagem "User already exists".
<img width="1919" height="1076" alt="Image" src="https://github.com/user-attachments/assets/d603feea-dcc5-4370-9ba1-2159f85687fa" />

### Lista de tarefas

#### Fluxo: Usuário não tem tarefas criadas
Quando o usuário ainda não tem tarefas criadas, o sistema mostra a mensagem "There are no tasks yet"
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/ca974c21-ae5b-4008-a9dd-15c6be9a9d32" />

### Criação de tarefas

#### Quando não há status criados ainda
Para criar uma tarefa, o usuário deve ter criado ao menos um status.

<img width="1919" height="925" alt="Image" src="https://github.com/user-attachments/assets/2c672915-4ffd-47d1-b683-905729e8308e" />

#### Quando há status criados

<img width="1884" height="694" alt="Image" src="https://github.com/user-attachments/assets/aeac32ee-9818-4ddd-8c71-6aeb22363acd" />
<img width="1919" height="510" alt="Image" src="https://github.com/user-attachments/assets/645b35a5-2875-4761-a361-d5fbf1a2ad86" />

### Edição de tarefas

<img width="1907" height="424" alt="Image" src="https://github.com/user-attachments/assets/1192f93e-95a7-4631-a72d-9ccb4cffc3c8" />
<img width="1860" height="1011" alt="Image" src="https://github.com/user-attachments/assets/7a33fa0a-b986-4887-80a1-42a4b616a88c" />
<img width="1919" height="321" alt="Image" src="https://github.com/user-attachments/assets/be8ff235-fbd3-4454-b559-36b2a733541c" />

### Listagem de status de tarefas

#### Fluxo: Não há status de tarefas
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/edcf45c9-feef-4da1-a717-83b70dadef15" />

#### Fluxo: Há um ou mais status de tarefas
<img width="1919" height="593" alt="Image" src="https://github.com/user-attachments/assets/fd0fa866-4d9b-4355-9934-e352bd8aa7aa" />

### Criação de status

<img width="1901" height="931" alt="Image" src="https://github.com/user-attachments/assets/3fa6291b-5f37-4368-b1b5-d60c65278a8b" />

### Deletar status

#### Fluxo: Quando há tarefas utilizando aquele status

<img width="1919" height="765" alt="Image" src="https://github.com/user-attachments/assets/4c05597d-184d-45fc-9fc9-79ed188d19e4" />

#### Fluxo: Quando não há tarefas utilizando o status

<img width="852" height="578" alt="Image" src="https://github.com/user-attachments/assets/d1bcda60-4a8f-4bc2-88da-0e89fbfddaf4" />
<img width="1917" height="291" alt="Image" src="https://github.com/user-attachments/assets/9a3771bf-ea0f-4e6d-8eec-e2c1fa52ce66" />

### Edição de status
Quando um status é editado, caso haja tarefas que utilizem o status, a mudança é refletida também na tarefa, mudando o nome do status na visualização.

No exemplo abaixo, o status se chamava "doing" e foi mudado para "do" e a edição foi refletida também na tarefa que estava associada ao status.

<img width="1918" height="415" alt="Image" src="https://github.com/user-attachments/assets/d184f9c1-2981-401f-8bae-0c340ea57b15" />
<img width="1919" height="233" alt="Image" src="https://github.com/user-attachments/assets/e35124e1-dcac-44d5-a0a4-1dcd56fe7084" />

## Lista de endpoints

### Endpoints principais do backend

- **GET** `/ping`: Verifica se o servidor está ativo.
- **POST** `/login`: Realiza o login do usuário.
- **POST** `/auth/refresh`: Atualiza o token de autenticação.
- **POST** `/users`: Cria um novo usuário.
- **POST** `/tasks`: Cria uma nova tarefa (autenticado).
- **GET** `/tasks`: Retorna todas as tarefas (autenticado).
- **PATCH** `/tasks/:id`: Atualiza uma tarefa específica (autenticado).
- **DELETE** `/tasks/:id`: Exclui uma tarefa específica (autenticado).
- **GET** `/task-status`: Retorna todos os status de tarefas (autenticado).
- **POST** `/task-status`: Cria um novo status de tarefa (autenticado).
- **PATCH** `/task-status/:id`: Atualiza um status de tarefa específico (autenticado).
- **DELETE** `/task-status/:id`: Exclui um status de tarefa específico (autenticado).

### Detalhes das Rotas
[**Coleção Postman**](/backend/postman_collection.json)

#### **GET** `/ping`
- **Descrição**: Verifica se o servidor está ativo.
- **Parâmetros**: Nenhum.
- **Retornos**: Resposta com a mensagem "Pong".

#### **POST** `/login`
- **Descrição**: Realiza o login do usuário.
- **Parâmetros**:
  - **Body**:
    ```json
    {
      "username": "string",
      "password": "string"
    }
    ```
- **Retornos**:
  - **200**: Retorna o token de autenticação.
    ```json
    {
      "accessToken": "string",
      "refreshToken": "string"
    }
    ```
  - **401**: Credenciais inválidas.

#### **POST** `/auth/refresh`
- **Descrição**: Atualiza o token de autenticação.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <refresh_token>"
    }
    ```
- **Retornos**:
  - **200**: Retorna um novo token de autenticação.
    ```json
    {
      "accessToken": "string"
    }
    ```
  - **401**: Token inválido ou expirado.

#### **POST** `/users`
- **Descrição**: Cria um novo usuário.
- **Parâmetros**:
  - **Body**:
    ```json
    {
      "username": "string",
      "password": "string"
    }
    ```
- **Retornos**:
  - **201**: Usuário criado com sucesso.
  - **400**: Usuário já existe.

#### **POST** `/tasks`
- **Descrição**: Cria uma nova tarefa.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
  - **Body**:
    ```json
    {
      "title": "string",
      "description": "string",
      "statusId": "number"
    }
    ```
- **Retornos**:
  - **201**: Tarefa criada com sucesso.
  - **400**: Dados inválidos.

#### **GET** `/tasks`
- **Descrição**: Retorna todas as tarefas do usuário autenticado.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
- **Retornos**:
  - **200**: Lista de tarefas.
    ```json
    [
      {
        "id": "number",
        "title": "string",
        "description": "string",
        "status": "string"
      }
    ]
    ```

#### **PATCH** `/tasks/:id`
- **Descrição**: Atualiza uma tarefa específica.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
  - **Body**:
    ```json
    {
      "title": "string",
      "description": "string",
      "statusId": "number"
    }
    ```
- **Retornos**:
  - **200**: Tarefa atualizada com sucesso.
  - **404**: Tarefa não encontrada.

#### **DELETE** `/tasks/:id`
- **Descrição**: Exclui uma tarefa específica.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
- **Retornos**:
  - **200**: Tarefa excluída com sucesso.
  - **404**: Tarefa não encontrada.

#### **GET** `/task-status`
- **Descrição**: Retorna todos os status de tarefas.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
- **Retornos**:
  - **200**: Lista de status de tarefas.
    ```json
    [
      {
        "id": "number",
        "name": "string"
      }
    ]
    ```

#### **POST** `/task-status`
- **Descrição**: Cria um novo status de tarefa.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
  - **Body**:
    ```json
    {
      "name": "string"
    }
    ```
- **Retornos**:
  - **201**: Status criado com sucesso.
  - **400**: Dados inválidos.

#### **PATCH** `/task-status/:id`
- **Descrição**: Atualiza um status de tarefa específico.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
  - **Body**:
    ```json
    {
      "name": "string"
    }
    ```
- **Retornos**:
  - **200**: Status atualizado com sucesso.
  - **404**: Status não encontrado.

#### **DELETE** `/task-status/:id`
- **Descrição**: Exclui um status de tarefa específico.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
- **Retornos**:
  - **200**: Status excluído com sucesso.
  - **404**: Status não encontrado.
