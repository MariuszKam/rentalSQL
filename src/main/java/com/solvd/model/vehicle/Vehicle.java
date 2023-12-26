package com.solvd.model.vehicle;

import java.util.Objects;

public class Vehicle {
    private Long id;
    private final VehicleType vehicleType;
    private final String model;
    private final String registrationNumber;
    private Long currentKilometers;
    private boolean status;

    public Vehicle(Long id, VehicleType vehicleType, String model, String registrationNumber, Long currentKilometers, boolean status) {
        this.id = id;
        this.vehicleType = vehicleType;
        this.model = model;
        this.registrationNumber = registrationNumber;
        this.currentKilometers = currentKilometers;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public VehicleType getVehicleType() {
        return vehicleType;
    }

    public String getModel() {
        return model;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public Long getCurrentKilometers() {
        return currentKilometers;
    }

    public void setCurrentKilometers(Long currentKilometers) {
        this.currentKilometers = currentKilometers;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vehicle vehicle = (Vehicle) o;
        return status == vehicle.status && Objects.equals(id, vehicle.id) && Objects.equals(vehicleType, vehicle.vehicleType) && Objects.equals(model, vehicle.model) && Objects.equals(registrationNumber, vehicle.registrationNumber) && Objects.equals(currentKilometers, vehicle.currentKilometers);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, vehicleType, model, registrationNumber, currentKilometers, status);
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id=" + id +
                ", vehicleTypeId=" + vehicleType +
                ", model='" + model + '\'' +
                ", registrationNumber='" + registrationNumber + '\'' +
                ", currentKilometers=" + currentKilometers +
                ", status=" + status +
                '}';
    }
}