package com.example.taskapi.dto;

import com.example.taskapi.entity.Task;

public record TaskRequest(
        String title,
        String description,
        Task.Status status
) {
}