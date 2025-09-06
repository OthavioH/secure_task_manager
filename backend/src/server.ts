import fastify from "fastify";
import fastifyCors from "@fastify/cors";
import dotenv from "dotenv";
import AppDataSource from "./config/db_data_source";
import routes from "./routes";
import { envConfig } from "./config/environment_config";

dotenv.config();

const app = fastify({
  logger: {
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true,
        translateTime: 'HH:MM:ss Z',
        ignore: 'pid,hostname'
      }
    }
  }
});

AppDataSource.initialize().then(() => {
  app.register(fastifyCors, {
    origin: envConfig.frontendAddress,
  });

  app.register(routes);

  const PORT = process.env.PORT || 3333;

  const start = async () => {
    try {
      await app.listen({ port: PORT as number, host: "0.0.0.0" }).then(() => {
        console.log(`Server started on port ${PORT}`);
      });
    } catch (err) {
      console.error(err);
      process.exit(1);
    }
  };

  start();
}).catch((error) => {
  console.error("Error starting server:", error);
});

export default app;
