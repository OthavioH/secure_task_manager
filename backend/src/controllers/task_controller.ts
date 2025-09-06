import AppDataSource from "../config/db_data_source";
import { FastifyRequest, FastifyReply } from "fastify";
import { Task } from "../entities/task";
import UpdateTaskBody from "../models/update_task_body";
import { TaskStatus } from "../entities/task_status";

export class TaskController {

    static async readAll(req: FastifyRequest<{ Querystring: { userId: string } }>, reply: FastifyReply) {
        const { userId } = req.query;
        if (!userId) {
            return reply.status(400).send({ error: "userId is required in query params" });
        }
        const taskRepository = AppDataSource.getRepository(Task);
        const tasks = await taskRepository.find({
            where: { user: { id: userId } },
            relations: ["user", "status"],
        });
        return reply.status(200).send(tasks);
    }

    static async store(req: FastifyRequest<{ Body: { userId: string, title: string, description: string, statusId?: string } }>, reply: FastifyReply) {
        const { userId, title, description, statusId } = req.body;

        const taskRepository = AppDataSource.getRepository(Task);
        const statusRepository = AppDataSource.getRepository(TaskStatus);

        let status: TaskStatus | null = null;

        if (!statusId) {
            return reply.code(400).send({ error: "StatusId é obrigatório" });
        }

        status = await statusRepository.findOne({ where: { id: statusId } });
        if (!status) return reply.code(400).send({ error: "Status inválido" });

        const task = taskRepository.create({
            title,
            description,
            user: { id: userId } as any,
            status,
        });
        await taskRepository.save(task);
        return reply.status(200).send(task);
    }

    static async update(req: FastifyRequest<{ Params: { id: string }; Body: { title?: string, description?: string, statusId?: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const { title, description, statusId } = req.body;
        const taskRepository = AppDataSource.getRepository(Task);
        const statusRepository = AppDataSource.getRepository(TaskStatus);
        const task = await taskRepository.findOne({ where: { id }, relations: ["status"] });
        if (!task) {
            return reply.code(404).send({ error: "Task não encontrada" });
        }
        if (title !== undefined) task.title = title;
        if (description !== undefined) task.description = description;
        if (statusId !== undefined) {
            const status = await statusRepository.findOne({ where: { id: statusId } });
            if (!status) return reply.code(400).send({ error: "Status inválido" });
            task.status = status;
        }
        await taskRepository.save(task);
        return reply.code(200).send(task);
    }

    static async delete(req: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) {
        const { id } = req.params;
        const taskRepository = AppDataSource.getRepository(Task);
        const task = await taskRepository.findOne({ where: { id } });
        if (!task) {
            return reply.code(404).send({ error: "Task não encontrada" });
        }
        await taskRepository.remove(task);
        return reply.code(204).send();
    }
}