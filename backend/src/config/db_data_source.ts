import { DataSource } from "typeorm";

import dotenv from "dotenv";
import { User } from "../entities/user";
import { Task } from "../entities/task";
import { TaskStatus } from "../entities/task_status";
import { Migration1757384324088 } from "../migrations/1757384324088-migration";

dotenv.config();

const AppDataSource = new DataSource({
  type: "postgres",
  ssl: process.env.NODE_ENV === "production",
  host: process.env.DB_HOST ?? "",
  username: process.env.DB_USERNAME ?? "",
  password: process.env.DB_PASSWORD ?? "",
  database: process.env.DB_NAME ?? "",
  port: Number(process.env.DB_PORT),
  synchronize: false,
  logging: false,
  entities: [User, Task, TaskStatus],
  subscribers: [],
  migrations: [Migration1757384324088],
});

export default AppDataSource;