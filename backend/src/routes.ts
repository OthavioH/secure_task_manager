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
  fastify.post("/auth/refresh", AuthController.refreshToken);

  fastify.post("/users", UserController.store);

  fastify.post("/tasks", { preHandler: [AuthMiddleware.authenticate]}, TaskController.store);
  fastify.get("/tasks", { preHandler: [AuthMiddleware.authenticate]}, TaskController.readAll);
  fastify.patch("/tasks/:id", { preHandler: [AuthMiddleware.authenticate]}, TaskController.update);
}
