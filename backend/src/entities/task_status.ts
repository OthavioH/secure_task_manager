import { Entity, PrimaryGeneratedColumn, Column, OneToMany, ManyToOne, Unique } from "typeorm";
import { Task } from "./task";
import { User } from "./user";

@Entity("task_statuses")
@Unique(["name", "user"])
export class TaskStatus {
    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column()
    name!: string;

    @OneToMany(() => Task, task => task.status)
    tasks!: Task[];

    @ManyToOne(() => User)
    user!: User;

}
