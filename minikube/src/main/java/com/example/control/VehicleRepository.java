package com.example.control;


import com.example.entity.Vehicle;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class VehicleRepository implements PanacheRepository<Vehicle> {
}