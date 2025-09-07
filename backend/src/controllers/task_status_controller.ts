import { FastifyRequest, FastifyReply } from "fastify";
import AppDataSource from "../config/db_data_source";
import { TaskStatus } from "../entities/task_status";

export class TaskStatusController {
    static async readAll(req: FastifyRequest<{ Querystring: { userId: string } }>, reply: FastifyReply) {
        const { userId } = req.query;

        if (!userId || userId.trim().length === 0) {
            return reply.code(400).send({ error: "userId is required" });
        }

        const repo = AppDataSource.getRepository(TaskStatus);
        const statuses = await repo.find({
            where: {
                user: { id: userId }
            }
        });
        return reply.send(statuses);
    }

    static async store(req: FastifyRequest<{ Body: { name: string, userId: string } }>, reply: FastifyReply) {
        const { name, userId } = req.body;

        if (!userId || userId.trim().length === 0) {
            return reply.code(400).send({ error: "userId is required" });
        }

        if (!name || name.trim().length === 0) {
            return reply.code(400).send({ error: "Name is required" });
        }

        const repo = AppDataSource.getRepository(TaskStatus);

        const exists = await repo.findOne({ where: { name, user: { id: userId } } });
        if (exists) return reply.code(409).send({ error: "Status already exists" });
        
        const status = repo.create({ name, user: { id: userId } });
        await repo.save(status);
        return reply.code(201).send(status);
    }

    static async update(req: FastifyRequest<{ Params: { id: string }; Body: { name: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const { name } = req.body;

        if (!id || !name) {
            return reply.code(400).send({ error: "Id and name are required" });
        }

        if (id.trim().length === 0 || name.trim().length === 0) {
            return reply.code(400).send({ error: "Id and name are required" });
        }

        const repo = AppDataSource.getRepository(TaskStatus);
        const status = await repo.findOne({ where: { id } });
        if (!status) return reply.code(404).send({ error: "Status not found" });

        status.name = name;
        await repo.save(status);
        return reply.send(status);
    }

    static async delete(req: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        if (!id || id.trim().length === 0) {
            return reply.code(400).send({ error: "Id is required" });
        }

        const repo = AppDataSource.getRepository(TaskStatus);
        const status = await repo.findOne({ where: { id } });

        if (!status) return reply.code(404).send({ error: "Status not found" });

        const taskCount = await AppDataSource.getRepository("Task").count({ where: { status: { id } } });
        if (taskCount > 0) {
            return reply.code(409).send({ error: "Cannot delete status: there are tasks using this status." });
        }

        await repo.remove(status);
        return reply.code(204).send();
    }
}
