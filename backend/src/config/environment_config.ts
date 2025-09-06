
import dotenv from "dotenv";

dotenv.config();

class EnvironmentConfig {

    jwtSecret: string;
    jwtRefreshSecret: string;
    frontendAddress: string;

    constructor() {
        this.jwtSecret = this.getEnvironmentVariable("SECRET")
        this.jwtRefreshSecret = this.getEnvironmentVariable("REFRESH_SECRET")
        this.frontendAddress = this.getEnvironmentVariable("FRONTEND_ADDRESS")
    }

    private getEnvironmentVariable(name: string):string {
        const envVariable = process.env[name];
        if (envVariable === undefined) {
            throw new Error(`${name} variable not set`);
        }
        return envVariable;
    }
}

export const envConfig = new EnvironmentConfig();