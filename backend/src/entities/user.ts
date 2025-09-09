import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("user")
export class User {

    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column({type: "varchar", length: "60", unique: true})
    username!: string;

    @Column({type: "varchar"})
    password!:string;
}