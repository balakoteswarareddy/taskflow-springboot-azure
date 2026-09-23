package com.example.taskapi.dto;

public record LoginRequest(
        String email,
        String password
) {
}
