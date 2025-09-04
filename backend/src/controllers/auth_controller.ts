import AppDataSource from "../config/db_data_source";
import { User } from "../entities/user";
import { FastifyRequest, FastifyReply } from "fastify";

import crypto from "crypto";

export class AuthController {
    private static userRepository = AppDataSource.getRepository(User);

    static async login(req: FastifyRequest<{ Body: { username: string, password: string } }>, reply: FastifyReply) {
        const { username, password } = req.body;

        const hashedPassword = crypto
            .createHash("md5")
            .update(password)
            .digest("hex");

        const user = await this.userRepository.findOne({
            where: {
                username,
            }
        });

        if(!user) {
            return reply.status(401).send({error: "Usuário ou senha inválidos"});
        }

        if(user.password != hashedPassword) {
            return reply.status(401).send({error: "Usuário ou senha inválidos"});
        }

        return reply.status(200).send(user);
    }
}