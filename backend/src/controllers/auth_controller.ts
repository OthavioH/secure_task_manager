import AppDataSource from "../config/db_data_source";
import { User } from "../entities/user";
import { FastifyRequest, FastifyReply } from "fastify";

import jwt from 'jsonwebtoken';
import { envConfig } from "../config/environment_config";
import JWTPayload from "../models/jwt_payload";
import UserTokens from "../models/user_tokens";

import bcrypt from "bcrypt";

export class AuthController {

    static async login(req: FastifyRequest<{ Body: { username: string, password: string } }>, reply: FastifyReply) {
        const { username, password } = req.body;

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
        
        const userRepository = AppDataSource.getRepository(User);

        const user = await userRepository.findOne({
            where: {
                username,
            },
        });

        if (!user) {
            return reply.status(401).send({ error: "Username or password is invalid" });
        }

        const isPasswordValid = await bcrypt.compare(password, user.password);

        if (!isPasswordValid) {
            return reply.status(401).send({ error: "Username or password is invalid" });
        }

        const tokens = AuthController.generateTokens({
            userId: user.id,
            username: user.username,
        });

        return reply.status(200).send({
            user: {
                id: user.id,
                username: user.username,
            },
            tokens: tokens,
        });
    }

    static async refreshToken(req: FastifyRequest, reply: FastifyReply) {
        try {
            const { authorization } = req.headers;

            if (authorization == null) {
                return reply.status(401).send({
                    error: "Refresh token is not valid"
                });
            }

            const refreshToken = authorization.replace("Bearer ", "");

            const payload = jwt.verify(refreshToken, envConfig.jwtRefreshSecret) as JWTPayload;

            const userRepository = AppDataSource.getRepository(User);
            
            const user = await userRepository.findOne({ where: { id: payload.userId } });
            
            if (!user) {
                return reply.status(404).send({ error: "User not found" });
            }

            const tokens = AuthController.generateTokens({
                userId: user.id,
                username: user.username,
            });

            return reply.status(200).send({
                tokens: tokens,
            });
        } catch (error) {
            console.error("Error refreshing token:", error);
            if (error instanceof jwt.JsonWebTokenError) {

                return reply.status(401).send({
                    error: "Refresh token is not valid"
                });
            }
            return reply.status(500).send({
                error: error,
            });
        }
    }

    private static generateTokens(payload: JWTPayload): UserTokens {
        const accessToken = jwt.sign(
            payload,
            envConfig.jwtSecret,
            { expiresIn: "15min" }
        );

        const refreshToken = jwt.sign(
            payload,
            envConfig.jwtRefreshSecret,
            { expiresIn: "7d" }
        );

        return { accessToken, refreshToken };
    }
}