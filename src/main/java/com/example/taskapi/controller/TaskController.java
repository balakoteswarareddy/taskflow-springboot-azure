package com.example.taskapi.controller;

import com.example.taskapi.dto.TaskRequest;
import com.example.taskapi.entity.Task;
import com.example.taskapi.service.TaskService;

import org.springframework.security.core.Authentication;
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
            Authentication authentication
    ) {

        String email = authentication.getName();

        return taskService.getTasks(email);
    }

    @GetMapping("/{id}")
    public Task getTask(
            @PathVariable Long id,
            Authentication authentication
    ) {

        return taskService.getTask(
                id,
                authentication.getName()
        );
    }

    @PostMapping
    public Task createTask(
            @RequestBody TaskRequest request,
            Authentication authentication
    ) {

        return taskService.createTask(
                request,
                authentication.getName()
        );
    }

    @DeleteMapping("/{id}")
    public String deleteTask(
            @PathVariable Long id,
            Authentication authentication
    ) {

        taskService.deleteTask(
                id,
                authentication.getName()
        );

        return "Task deleted successfully";
    }
}
