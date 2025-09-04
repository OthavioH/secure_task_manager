import AppDataSource from "../config/db_data_source";
import { FastifyRequest, FastifyReply } from "fastify";
import { Task } from "../entities/task";
import UpdateTaskBody from "../models/update_task_body";
import { TaskStatus } from "../models/task_status";

export class TaskController {
    private static taskRepository = AppDataSource.getRepository(Task);

    static async readAll(req: FastifyRequest<{ Querystring: { userId: string } }>, reply: FastifyReply) {
        const { userId } = req.query;

        if(!userId) {
            return reply.status(400).send({
                error: "userId is required in query params"
            });
        }

        const tasks = TaskController.taskRepository.find(
            {
                where: {
                    user: {
                        id: userId,
                    }
                }
            }
        );

        return reply.status(200).send(tasks);
    }

    static async store(req: FastifyRequest<{ Body: { userId: string, title: string, description: string } }>, reply: FastifyReply) {
        const { userId, title, description } = req.body;

        const task = TaskController.taskRepository.create(
            {
                title: title,
                description: description,
                user: {
                    id: userId,
                }
            }
        );

        await this.taskRepository.save(task);

        return reply.status(200).send(task);
    }

    static async update(req: FastifyRequest<{ Params: { id: string }; Body: UpdateTaskBody }>, reply: FastifyReply) {
        const { id } = req.params;
        const { title, description, status } = req.body;

        const task = await this.taskRepository.findOne({ where: { id } });
        if (!task) {
            return reply.code(404).send({ error: "Task não encontrada" });
        }

        if (title !== undefined) task.title = title;
        if (description !== undefined) task.description = description;

        if (status !== undefined) {
            if (!Object.values(TaskStatus).includes(status)) {
                return reply.code(400).send({ error: "Status inválido" });
            }
            task.status = status;
        }

        await this.taskRepository.save(task);

        return reply.code(200).send(task);
    }
}