import { TaskStatus } from "./task_status";

export default interface UpdateTaskBody {
  title?: string;
  description?: string;
  status?: TaskStatus;
}