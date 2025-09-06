import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1757195047292 implements MigrationInterface {
    name = 'Migration1757195047292'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`task\` CHANGE \`statusId\` \`status\` varchar(36) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`task\` DROP COLUMN \`status\``);
        await queryRunner.query(`ALTER TABLE \`task\` ADD \`status\` enum ('pending', 'in_progress', 'done') NOT NULL DEFAULT 'pending'`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`task\` DROP COLUMN \`status\``);
        await queryRunner.query(`ALTER TABLE \`task\` ADD \`status\` varchar(36) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`task\` CHANGE \`status\` \`statusId\` varchar(36) NOT NULL`);
    }

}
