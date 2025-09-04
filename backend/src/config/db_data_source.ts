import { DataSource } from "typeorm";

import dotenv from "dotenv";
import { User } from "../entities/user";
import { Task } from "../entities/task";

dotenv.config();

const AppDataSource = new DataSource({
  type: "mysql",
  host: process.env.DB_HOST ?? "",
  username: process.env.DB_USERNAME ?? "",
  password: process.env.DB_PASSWORD ?? "",
  database: process.env.DB_NAME ?? "",
  port: Number(process.env.DB_PORT),
  synchronize: true,
  logging: false,
  entities: [User, Task],
  subscribers: [],
  migrations: [],
});

export default AppDataSource;