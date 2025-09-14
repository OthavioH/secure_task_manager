import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1757861433511 implements MigrationInterface {
    name = 'Migration1757861433511'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "task_statuses" DROP CONSTRAINT "UQ_324e55243a54dec785cedf743ba"`);
        await queryRunner.query(`ALTER TABLE "task_statuses" ADD CONSTRAINT "UQ_cd85d5008363d08db45f0b42dcb" UNIQUE ("name", "userId")`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "task_statuses" DROP CONSTRAINT "UQ_cd85d5008363d08db45f0b42dcb"`);
        await queryRunner.query(`ALTER TABLE "task_statuses" ADD CONSTRAINT "UQ_324e55243a54dec785cedf743ba" UNIQUE ("name")`);
    }

}
