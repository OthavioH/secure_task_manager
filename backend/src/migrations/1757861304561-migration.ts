import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1757861304561 implements MigrationInterface {
    name = 'Migration1757861304561'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "task_statuses" DROP CONSTRAINT "UQ_324e55243a54dec785cedf743ba"`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "task_statuses" ADD CONSTRAINT "UQ_324e55243a54dec785cedf743ba" UNIQUE ("name")`);
    }

}
