package com.example.taskapi.service;

import com.example.taskapi.dto.TaskRequest;
import com.example.taskapi.entity.Task;
import com.example.taskapi.entity.User;
import com.example.taskapi.repository.TaskRepository;
import com.example.taskapi.repository.UserRepository;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class TaskService {

    private final TaskRepository taskRepository;
    private final UserRepository userRepository;

    public TaskService(
            TaskRepository taskRepository,
            UserRepository userRepository
    ) {
        this.taskRepository = taskRepository;
        this.userRepository = userRepository;
    }

    public List<Task> getTasks(String email) {
        return taskRepository.findByUserEmail(email);
    }

    public Task createTask(
            TaskRequest request,
            String email
    ) {

        User user = userRepository
                .findByEmail(email)
                .orElseThrow();

        Task task = new Task();

        task.setTitle(request.title());
        task.setDescription(request.description());
        task.setStatus(request.status());
        task.setUser(user);
        task.setCreatedAt(LocalDateTime.now());

        return taskRepository.save(task);
    }

    public Task getTask(Long id, String email) {

        Task task = taskRepository
                .findById(id)
                .orElseThrow();

        if (!task.getUser().getEmail().equals(email)) {
            throw new RuntimeException("Access denied");
        }

        return task;
    }

    public void deleteTask(Long id, String email) {

        Task task = getTask(id, email);

        taskRepository.delete(task);
    }
}