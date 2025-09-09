import AppDataSource from "../config/db_data_source";
import { User } from "../entities/user";
import { FastifyRequest, FastifyReply } from "fastify";

import bcrypt from "bcrypt";

export class UserController {
    
    static async store(req: FastifyRequest<{Body: {username: string, password: string}}>, reply: FastifyReply) {
        const  {username, password} = req.body;
        
        if(!username || !password) {
            return reply.status(400).send({
                error: "Username and password are required."
            });
        }

        if(username.trim().length === 0 || password.trim().length === 0) {
            return reply.status(400).send({
                error: "Username and password are required."
            });
        }

        if(password.length < 6) {
            return reply.status(400).send({
                error: "Password must be at least 6 characters long."
            });
        }

        const userRepository = AppDataSource.getRepository(User);

        const hasUser = await userRepository.findOne({
            where: {
                username,
            }
        });

        if(hasUser) {
            return reply.status(409).send({
                error: "User already exists."
            });
        }

        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        const user = userRepository.create({
            username,
            password: hashedPassword,
        });
        
        await userRepository.save(user);

        return reply.status(201).send(user);
    }
}