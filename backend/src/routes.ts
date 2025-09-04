import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { UserController } from "./controllers/user_controller";
import { AuthController } from "./controllers/auth_controller";
import { TaskController } from "./controllers/task_controller";

export default async function routes(fastify: FastifyInstance) {
  fastify.get("/ping", (req: FastifyRequest, reply: FastifyReply) => {
    return reply.send("Pong");
  });

  fastify.post("/login", AuthController.login);

  fastify.post("/user", UserController.store);
  
  fastify.post("/task", TaskController.store);
  fastify.get("/task", TaskController.readAll);
  fastify.patch("/task", TaskController.update);
}
