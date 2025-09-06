import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1757195356185 implements MigrationInterface {
    name = 'Migration1757195356185'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`task\` DROP FOREIGN KEY \`FK_02068239bb8d5b2fc7f3ded618c\``);
        await queryRunner.query(`ALTER TABLE \`task\` CHANGE \`statusId\` \`status\` varchar(36) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`task\` DROP COLUMN \`status\``);
        await queryRunner.query(`ALTER TABLE \`task\` ADD \`status\` enum ('pending', 'in_progress', 'done') NOT NULL DEFAULT 'pending'`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`task\` DROP COLUMN \`status\``);
        await queryRunner.query(`ALTER TABLE \`task\` ADD \`status\` varchar(36) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`task\` CHANGE \`status\` \`statusId\` varchar(36) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`task\` ADD CONSTRAINT \`FK_02068239bb8d5b2fc7f3ded618c\` FOREIGN KEY (\`statusId\`) REFERENCES \`task_status\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

}
