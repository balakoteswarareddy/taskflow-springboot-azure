package com.example.taskapi.entity;

import jakarta.persistence.*;

@Entity
@Table(
    name = "TASK_API_USERS",
    uniqueConstraints = {
        @UniqueConstraint(
            name = "uk_user_tenant_object",
            columnNames = {"tenant_id", "entra_object_id"}
        )
    }
)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TENANT_ID", nullable = false)
    private String tenantId;

    @Column(name = "ENTRA_OBJECT_ID", nullable = false)
    private String entraObjectId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String email;

    public User() {
    }

    public User(
            String tenantId,
            String entraObjectId,
            String name,
            String email
    ) {
        this.tenantId = tenantId;
        this.entraObjectId = entraObjectId;
        this.name = name;
        this.email = email;
    }

    public Long getId() {
        return id;
    }

    public String getTenantId() {
        return tenantId;
    }

    public String getEntraObjectId() {
        return entraObjectId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public void setEntraObjectId(String entraObjectId) {
        this.entraObjectId = entraObjectId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}