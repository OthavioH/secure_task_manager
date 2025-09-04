import AppDataSource from "../config/db_data_source";
import { User } from "../entities/user";
import { FastifyRequest, FastifyReply } from "fastify";

import crypto from "crypto";

export class UserController {
    private static userRepository = AppDataSource.getRepository(User);
    
    static async store(req: FastifyRequest<{Body: {username: string, password: string}}>, reply: FastifyReply) {
        const  {username, password} = req.body;

        const hasUser = await this.userRepository.findOne({
            where: {
                username,
            }
        });

        if(hasUser) {
            return reply.status(409).send({
                error: "Usuário já existe."
            });
        }

        const hashedPassword = crypto
            .createHash("md5")
            .update(password)
            .digest("hex");

        const user = this.userRepository.create({
            username,
            password: hashedPassword,
        });
        
        await this.userRepository.save(user);

        return reply.status(200).send(user);
    }
}