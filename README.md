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
│   ├── src/
│   │   ├── migrations/            # Migrations do banco de dados (TypeORM)
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
<img width="1903" height="1078" alt="Image" src="https://github.com/user-attachments/assets/5bc87174-2115-48e8-afc8-5a9e479ff4a8" />

#### Fluxo: Credenciais incorretas
Quando as credenciais do usuário estão incorretas, seja a senha ou o username, o sistema mostra a mensagem "Your username or password is incorrect".
<img width="1330" height="811" alt="Image" src="https://github.com/user-attachments/assets/cf2963cd-2785-42d6-9d40-85a8f9177565" />

### Criação de conta
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/e62bb0fa-3108-492a-ad45-146fdefe028e" />

#### Fluxo: Conta criada com sucesso
Quando há a criação de conta com sucesso, o sistema mostra uma mensagem e redireciona o usuário para a tela de Login.
<img width="1510" height="994" alt="Image" src="https://github.com/user-attachments/assets/010c4b20-6c94-48cb-862a-aeb79a3e8d0d" />

#### Fluxo: Conta já existente
Quando há uma conta com o mesmo username, o sistema mostra a mensagem "User already exists".
<img width="746" height="523" alt="Image" src="https://github.com/user-attachments/assets/716b6583-1436-48d6-ab78-0d0cb65860b5" />

### Lista de tarefas

#### Fluxo: Usuário não tem tarefas criadas
Quando o usuário ainda não tem tarefas criadas, o sistema mostra a mensagem "There are no tasks yet"
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/53957576-2210-4c2d-b847-c8f20e2219e2" />

#### Fluxo: Usuário tem tarefas criadas


### Criação de tarefas

#### Quando não há status criados ainda
Para criar uma tarefa, o usuário deve ter criado ao menos um status.

<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/32f07400-5f14-4361-a4b8-bf5ec216343c" />

#### Quando há status criados

<img width="1644" height="735" alt="Image" src="https://github.com/user-attachments/assets/e47ed030-c14a-4453-8318-6a62ac6d48d2" />
<img width="1917" height="1079" alt="Image" src="https://github.com/user-attachments/assets/9f0d80a8-5552-40ef-a3f0-a982130c1eec" />

### Edição de tarefas

<img width="1382" height="614" alt="Image" src="https://github.com/user-attachments/assets/0a75c60d-dcab-4cd0-95ff-5c8e71e1e28f" />
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/aa8d27b8-82e6-4bc4-8790-d9be0300932c" />

### Deletar tarefas
<img width="834" height="618" alt="Image" src="https://github.com/user-attachments/assets/c87f7900-14fd-4f8a-87c6-995a7552c5cc" />
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/e3e3450d-d738-4372-bfdc-97197b426360" />

### Listagem de status de tarefas

#### Fluxo: Não há status de tarefas
<img width="1902" height="1079" alt="Image" src="https://github.com/user-attachments/assets/7f4f8485-4a03-44dd-b218-782ab2b1d800" />

#### Fluxo: Há um ou mais status de tarefas
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/3106480e-c23d-4ff7-bd31-5b3e88085e88" />

### Criação de status

#### Quando há um status criado com o mesmo nome para aquele usuário
<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/3ccc8905-1de0-4f37-84b9-61de02f879f9" />

#### Quando a criação de status é bem sucedida
<img width="1045" height="415" alt="Image" src="https://github.com/user-attachments/assets/f7f23cc8-97ad-4910-bb44-47f59ce9bd8f" />

### Deletar status

#### Fluxo: Quando há tarefas utilizando aquele status

<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/023eae1c-1e71-405a-bdb7-2f40442e9f52" />

#### Fluxo: Quando não há tarefas utilizando o status

<img width="1919" height="1079" alt="Image" src="https://github.com/user-attachments/assets/af859107-d6d4-4253-9167-428e5fb1edbb" />

### Edição de status
Quando um status é editado, caso haja tarefas que utilizem o status, a mudança é refletida também na tarefa, mudando o nome do status na visualização.

No exemplo abaixo, o status se chamava "pending" e foi mudado para "to-do" e a edição foi refletida também na tarefa que estava associada ao status.

<img width="530" height="447" alt="Image" src="https://github.com/user-attachments/assets/8dd0da05-e74a-42e0-bced-e0a03b6c293f" />
<img width="743" height="492" alt="Image" src="https://github.com/user-attachments/assets/3b19c580-bef7-45b5-8019-a5a165fb540a" />
<img width="579" height="561" alt="Image" src="https://github.com/user-attachments/assets/e9ebab27-09de-4161-b5f1-dd7a9e89788c" />

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
- **Descrição**: Retorna todas as tarefas do usuário autenticado e aceita um parâmetro de statusId para filtrar tarefas por aquele status.
- **Parâmetros**:
  - **Headers**:
    ```json
    {
      "Authorization": "Bearer <token>"
    }
    ```
  - **Query Params**:
    - `statusId` (opcional): ID do status para filtrar as tarefas.
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
