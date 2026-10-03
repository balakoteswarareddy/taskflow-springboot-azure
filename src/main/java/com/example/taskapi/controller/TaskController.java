package com.example.taskapi.controller;

import com.example.taskapi.dto.TaskRequest;
import com.example.taskapi.entity.Task;
import com.example.taskapi.service.TaskService;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private final TaskService taskService;

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @GetMapping
    public List<Task> getTasks(
            @AuthenticationPrincipal Jwt jwt
    ) {
        return taskService.getTasks(jwt);
    }

    @GetMapping("/{id}")
    public Task getTask(
            @PathVariable Long id,
            @AuthenticationPrincipal Jwt jwt
    ) {
        return taskService.getTask(id, jwt);
    }

    @PostMapping
    public Task createTask(
            @RequestBody TaskRequest request,
            @AuthenticationPrincipal Jwt jwt
    ) {
        return taskService.createTask(request, jwt);
    }

    @DeleteMapping("/{id}")
    public String deleteTask(
            @PathVariable Long id,
            @AuthenticationPrincipal Jwt jwt
    ) {
        taskService.deleteTask(id, jwt);
        return "Task deleted successfully";
    }
}