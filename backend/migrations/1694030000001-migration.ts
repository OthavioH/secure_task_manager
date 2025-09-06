import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1694030000001 implements MigrationInterface {

    name = 'Migration1694030000001'
    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            INSERT INTO "task_status" ("name") VALUES
            ('pending'),
            ('in progress'),
            ('done');
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            DELETE FROM "task_status" WHERE "name" IN ('pending', 'in progress', 'done');
        `);
    }
}
