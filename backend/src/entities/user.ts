import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class User {

    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column({type: "varchar", length: "60", unique: true})
    username!: string;

    @Column({type: "varchar"})
    password!:string;
}