import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from "typeorm";
import { Task } from "./task";

@Entity()
export class TaskStatus {
    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column({ unique: true })
    name!: string;

    @OneToMany(() => Task, task => task.status)
    tasks!: Task[];
}
