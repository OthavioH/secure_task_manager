import { Entity, PrimaryGeneratedColumn, Column, OneToMany, ManyToOne } from "typeorm";
import { Task } from "./task";
import { User } from "./user";

@Entity("task_statuses")
export class TaskStatus {
    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column({ unique: true })
    name!: string;

    @OneToMany(() => Task, task => task.status)
    tasks!: Task[];

    @ManyToOne(() => User)
    user!: User;

}
