import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1757383744415 implements MigrationInterface {
    name = 'Migration1757383744415'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "user" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "username" character varying(60) NOT NULL, "password" character varying NOT NULL, CONSTRAINT "UQ_78a916df40e02a9deb1c4b75edb" UNIQUE ("username"), CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "task_status" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "name" character varying NOT NULL, "userId" uuid, CONSTRAINT "UQ_b0c955f276679dd2b2735c3936a" UNIQUE ("name"), CONSTRAINT "PK_b8747cc6a41b6cef4639babf61d" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "task" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "title" character varying NOT NULL, "description" character varying NOT NULL, "statusId" uuid, "userId" uuid NOT NULL, CONSTRAINT "PK_fb213f79ee45060ba925ecd576e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "task_status" ADD CONSTRAINT "FK_c8af924130ac032ffbe24285a31" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "task" ADD CONSTRAINT "FK_02068239bb8d5b2fc7f3ded618c" FOREIGN KEY ("statusId") REFERENCES "task_status"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "task" ADD CONSTRAINT "FK_f316d3fe53497d4d8a2957db8b9" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "task" DROP CONSTRAINT "FK_f316d3fe53497d4d8a2957db8b9"`);
        await queryRunner.query(`ALTER TABLE "task" DROP CONSTRAINT "FK_02068239bb8d5b2fc7f3ded618c"`);
        await queryRunner.query(`ALTER TABLE "task_status" DROP CONSTRAINT "FK_c8af924130ac032ffbe24285a31"`);
        await queryRunner.query(`DROP TABLE "task"`);
        await queryRunner.query(`DROP TABLE "task_status"`);
        await queryRunner.query(`DROP TABLE "user"`);
    }

}
