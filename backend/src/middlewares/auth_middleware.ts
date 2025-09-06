import { FastifyReply, FastifyRequest, RouteGenericInterface } from "fastify";

import jwt from "jsonwebtoken";
import { envConfig } from "../config/environment_config";
import JWTPayload from "../models/jwt_payload";

export default class AuthMiddleware {

    static async authenticate<T extends RouteGenericInterface = any>(request: FastifyRequest<T>, reply: FastifyReply): Promise<void> {
        try {
            const {authorization} = request.headers;

            if(authorization == null) {
                throw new Error
            }

            jwt.verify(authorization, envConfig.jwtSecret) as JWTPayload;
        } catch (err) {
            reply.status(401).send({
                error: err,
            });
        }
    }
}