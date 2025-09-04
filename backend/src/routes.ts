import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";

export default async function routes(fastify: FastifyInstance) {
  fastify.get("/ping", (req: FastifyRequest, reply: FastifyReply) => {
    return reply.send("Pong");
  });
}
