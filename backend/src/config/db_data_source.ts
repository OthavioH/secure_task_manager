import { DataSource } from "typeorm";

import dotenv from "dotenv";
import { User } from "../entities/user";
import { Task } from "../entities/task";
import { TaskStatus } from "../entities/task_status";

dotenv.config();

const AppDataSource = new DataSource({
  type: "postgres",
  ssl: process.env.NODE_ENV === "production",
  host: process.env.DB_HOST ?? "",
  username: process.env.DB_USERNAME ?? "",
  password: process.env.DB_PASSWORD ?? "",
  database: process.env.DB_NAME ?? "",
  port: Number(process.env.DB_PORT),
  synchronize: false, // Desativado para evitar problemas com SQL gerado automaticamente
  logging: false,
  entities: [User, Task, TaskStatus],
  subscribers: [],
  migrations: ["src/migrations/*.ts"],
});

export default AppDataSource;