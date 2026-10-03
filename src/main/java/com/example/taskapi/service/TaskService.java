package com.example.taskapi.service;

import com.example.taskapi.dto.TaskRequest;
import com.example.taskapi.entity.Task;
import com.example.taskapi.entity.User;
import com.example.taskapi.repository.TaskRepository;
import com.example.taskapi.repository.UserRepository;

import org.springframework.security.oauth2.jwt.Jwt;
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

    private User getOrCreateUser(Jwt jwt) {

        String tenantId = jwt.getClaimAsString("tid");
        String entraObjectId = jwt.getClaimAsString("oid");

        if (tenantId == null || entraObjectId == null) {
            throw new RuntimeException(
                    "Required Entra identity claims are missing"
            );
        }

        return userRepository
                .findByTenantIdAndEntraObjectId(
                        tenantId,
                        entraObjectId
                )
                .orElseGet(() -> {

                    String name = jwt.getClaimAsString("name");
                    String email = jwt.getClaimAsString("preferred_username");

                    User user = new User(
                            tenantId,
                            entraObjectId,
                            name != null ? name : "Unknown User",
                            email != null ? email : "Unknown"
                    );

                    return userRepository.save(user);
                });
    }

    public List<Task> getTasks(Jwt jwt) {

        String tenantId = jwt.getClaimAsString("tid");
        String entraObjectId = jwt.getClaimAsString("oid");

        return taskRepository.findByUserTenantIdAndUserEntraObjectId(
                tenantId,
                entraObjectId
        );
    }

    public Task createTask(TaskRequest request, Jwt jwt) {

        User user = getOrCreateUser(jwt);

        Task task = new Task();

        task.setTitle(request.title());
        task.setDescription(request.description());
        task.setStatus(request.status());
        task.setUser(user);
        task.setCreatedAt(LocalDateTime.now());

        return taskRepository.save(task);
    }

    public Task getTask(Long id, Jwt jwt) {

        User user = getOrCreateUser(jwt);

        Task task = taskRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Task not found")
                );

        if (!task.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Access denied");
        }

        return task;
    }

    public void deleteTask(Long id, Jwt jwt) {

        Task task = getTask(id, jwt);

        taskRepository.delete(task);
    }
}