import AppDataSource from "../config/db_data_source";
import { FastifyRequest, FastifyReply } from "fastify";
import { Task } from "../entities/task";
import { TaskStatus } from "../entities/task_status";

export class TaskController {

    static async readAll(req: FastifyRequest<{ Querystring: { userId: string, statusId: string } }>, reply: FastifyReply) {
        const { userId, statusId } = req.query;
        if (!userId) {
            return reply.status(400).send({ error: "userId is required in query params" });
        }
        if (statusId && statusId.trim().length === 0) {
            return reply.status(400).send({ error: "statusId cannot be empty" });
        }
        const taskRepository = AppDataSource.getRepository(Task);
        const tasks = await taskRepository.find({
            where: {
                user: { id: userId },
                ...(statusId ? { status: { id: statusId } } : {}),
            },
            relations: ["user", "status"],
        });
        return reply.status(200).send(tasks);
    }

    static async store(req: FastifyRequest<{ Body: { userId: string, title: string, description: string, statusId?: string } }>, reply: FastifyReply) {
        const { userId, title, description, statusId } = req.body;

        if (!userId || !title || !description || !statusId) {
            return reply.status(400).send({
                error: "UserId, title, description and statusId are required."
            });
        }

        if (userId.trim().length === 0 || title.trim().length === 0 || description.trim().length === 0 || statusId.trim().length === 0) {
            return reply.status(400).send({
                error: "UserId, title, description and statusId are required."
            });
        }

        const taskRepository = AppDataSource.getRepository(Task);
        const statusRepository = AppDataSource.getRepository(TaskStatus);

        let status: TaskStatus | null = null;

        status = await statusRepository.findOne({ where: { id: statusId } });
        if (!status) return reply.code(404).send({ error: "Could not find status" });

        const task = taskRepository.create({
            title,
            description,
            user: { id: userId } as any,
            status,
        });
        await taskRepository.save(task);
        return reply.status(201).send(task);
    }

    static async update(req: FastifyRequest<{ Params: { id: string }; Body: { title?: string, description?: string, statusId?: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const { title, description, statusId } = req.body;

        if (!id || !title || !description || !statusId) {
            return reply.code(400).send({ error: "Id, title, description and statusId are required" });
        }

        if (id.trim().length === 0 || title.trim().length === 0 || description.trim().length === 0 || statusId.trim().length === 0) {
            return reply.code(400).send({ error: "Id, title, description and statusId are required" });
        }

        const taskRepository = AppDataSource.getRepository(Task);
        const statusRepository = AppDataSource.getRepository(TaskStatus);

        const task = await taskRepository.findOne({ where: { id }, relations: ["status"] });

        if (!task) {
            return reply.code(404).send({ error: "Task not found" });
        }

        if (title !== undefined) task.title = title;
        if (description !== undefined) task.description = description;
        if (statusId !== undefined) {
            const status = await statusRepository.findOne({ where: { id: statusId } });
            if (!status) return reply.code(404).send({ error: "statusId is invalid" });
            task.status = status;
        }
        await taskRepository.save(task);
        return reply.code(200).send(task);
    }

    static async delete(req: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        if (!id) {
            return reply.code(400).send({ error: "Id is required" });
        }
        if (id.trim().length === 0) {
            return reply.code(400).send({ error: "Id is required" });
        }

        const taskRepository = AppDataSource.getRepository(Task);
        const task = await taskRepository.findOne({ where: { id } });
        if (!task) {
            return reply.code(404).send({ error: "Task not found" });
        }
        await taskRepository.remove(task);
        return reply.code(204).send();
    }
}