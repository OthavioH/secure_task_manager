import AppDataSource from "../config/db_data_source";
import { User } from "../entities/user";
import { FastifyRequest, FastifyReply } from "fastify";

import crypto from "crypto";
import jwt from 'jsonwebtoken';
import { envConfig } from "../config/environment_config";
import JWTPayload from "../models/jwt_payload";
import UserTokens from "../models/user_tokens";

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

        if (!user) {
            return reply.status(401).send({ error: "Usuário ou senha inválidos" });
        }

        if (user.password != hashedPassword) {
            return reply.status(401).send({ error: "Usuário ou senha inválidos" });
        }

        const tokens = this.generateTokens({
            userId: user.id,
            username: user.username,
        });

        return reply.status(200).send(tokens);
    }

    static async refreshToken(req: FastifyRequest, reply: FastifyReply) {
        try {
            const { authorization } = req.headers;

            if (authorization == null) {
                return reply.status(401).send({
                    error: "Refresh token is not valid"
                });
            }

            const payload = jwt.verify(authorization, envConfig.jwtRefreshSecret) as JWTPayload;

            
            const user = await this.userRepository.findOne({ where: { id: payload.userId } });
            
            if (!user) {
                return reply.status(404).send({ error: "Usuário não encontrado" });
            }

            const tokens = this.generateTokens(payload);

            return reply.status(200).send(tokens);
        } catch (error) {
            return reply.status(401).send({
                error: "Refresh token is not valid"
            });
        }
    }

    private static generateTokens(payload: JWTPayload): UserTokens {
        const accessToken = jwt.sign(
            payload,
            envConfig.jwtSecret,
            { expiresIn: "15m" }
        );

        const refreshToken = jwt.sign(
            payload,
            envConfig.jwtRefreshSecret,
            { expiresIn: "7d" }
        );

        return { accessToken, refreshToken };
    }
}