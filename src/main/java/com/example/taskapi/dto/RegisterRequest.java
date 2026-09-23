package com.example.taskapi.dto;

public record RegisterRequest(
        String name,
        String email,
        String password
) {
}
