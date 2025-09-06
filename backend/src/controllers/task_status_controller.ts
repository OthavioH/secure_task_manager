import { FastifyRequest, FastifyReply } from "fastify";
import AppDataSource from "../config/db_data_source";
import { TaskStatus } from "../entities/task_status";

export class TaskStatusController {
    static async readAll(req: FastifyRequest, reply: FastifyReply) {
        const repo = AppDataSource.getRepository(TaskStatus);
        const statuses = await repo.find();
        return reply.send(statuses);
    }

    static async store(req: FastifyRequest<{ Body: { name: string } }>, reply: FastifyReply) {
        const { name } = req.body;
        const repo = AppDataSource.getRepository(TaskStatus);
        const exists = await repo.findOne({ where: { name } });
        if (exists) return reply.code(400).send({ error: "Status já existe" });
        const status = repo.create({ name });
        await repo.save(status);
        return reply.code(201).send(status);
    }

    static async update(req: FastifyRequest<{ Params: { id: string }; Body: { name: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const { name } = req.body;
        const repo = AppDataSource.getRepository(TaskStatus);
        const status = await repo.findOne({ where: { id } });
        if (!status) return reply.code(404).send({ error: "Status não encontrado" });
        status.name = name;
        await repo.save(status);
        return reply.send(status);
    }

    static async delete(req: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const repo = AppDataSource.getRepository(TaskStatus);
        const status = await repo.findOne({ where: { id } });
        if (!status) return reply.code(404).send({ error: "Status não encontrado" });
        await repo.remove(status);
        return reply.code(204).send();
    }
}
