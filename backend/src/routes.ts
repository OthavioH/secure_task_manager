import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { UserController } from "./controllers/user_controller";
import { AuthController } from "./controllers/auth_controller";
import { TaskController } from "./controllers/task_controller";
import AuthMiddleware from "./middlewares/auth_middleware";

export default async function routes(fastify: FastifyInstance) {
  fastify.get("/ping", (req: FastifyRequest, reply: FastifyReply) => {
    return reply.send("Pong");
  });

  fastify.post("/login", AuthController.login);

  fastify.post("/user", UserController.store);

  fastify.post("/task", { preHandler: [AuthMiddleware.authenticate]}, TaskController.store);
  fastify.get("/task", { preHandler: [AuthMiddleware.authenticate]}, TaskController.readAll);
  fastify.patch("/task", { preHandler: [AuthMiddleware.authenticate]}, TaskController.update);
}
