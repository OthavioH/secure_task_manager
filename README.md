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
├── .github/
│   └── workflows/
│       └── build_web.yml      # Pipeline de CI/CD para a build da versão web
├── backend/
│   ├── migrations/            # Migrations do banco de dados (TypeORM)
│   ├── src/
│   │   ├── config/            # Configurações de ambiente e banco de dados
│   │   ├── controllers/       # Controladores que lidam com as requisições HTTP
│   │   ├── entities/          # Modelos de dados (tabelas do banco)
│   │   ├── middlewares/       # Middlewares (ex: verificação de autenticação)
│   │   ├── models/            # Tipos e interfaces auxiliares
│   │   ├── routes.ts          # Definição de todas as rotas da API
│   │   └── server.ts          # Ponto de entrada do servidor Fastify
│   ├── .env.example           # Exemplo de variáveis de ambiente
│   ├── docker-compose.db.mysql.yml # Docker Compose para subir um container MySQL
│   ├── docker-compose.db.postgres.yml # Docker Compose para subir um container Postgres
│   ├── package.json
│   └── tsconfig.json
└── frontend/
    ├── lib/
    │   ├── core/              # Configurações globais e utilitários
    │   ├── features/          # Módulos do app, separados por funcionalidade (Auth, Task, etc.)
    │   │   └── [feature_name]/
    │   │       ├── data/      # Implementação de repositórios e fontes de dados
    │   │       ├── domain/    # Lógica de negócio, modelos e interfaces (abstração)
    │   │       ├── exceptions/  # Exceções customizadas da funcionalidade
    │   │       └── presentation/ # Widgets (UI), controllers e gerenciamento de estado
    │   ├── routes/            # Configuração das rotas de navegação
    │   ├── shared/            # Widgets e serviços compartilhados entre as features
    │   ├── theme/             # Definição do tema da aplicação
    │   └── main.dart          # Ponto de entrada da aplicação Flutter
    ├── web/                   # Arquivos específicos para a plataforma web
    ├── .env.example           # Exemplo de variáveis de ambiente
    ├── analysis_options.yaml  # Regras de lint e análise estática
    └── pubspec.yaml           # Dependências e configuração do projeto Flutter
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
