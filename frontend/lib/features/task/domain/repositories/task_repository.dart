
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getUserTasks(String userId);
}