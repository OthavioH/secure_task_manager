import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm"
import { User } from "./user";
import { TaskStatus } from "./task_status";

@Entity()
export class Task {
    @PrimaryGeneratedColumn("uuid")
    id!: string;

    @Column()
    title!: string;

    @Column()
    description!: string;

    @ManyToOne(() => TaskStatus, status => status.tasks, { nullable: true })
    status?: TaskStatus;

    @ManyToOne(() => User, { nullable: false })
    user!: User;
}
