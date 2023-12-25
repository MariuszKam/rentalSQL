package com.solvd.persistence.persons.employee;

import com.solvd.model.persons.customer.Customer;
import com.solvd.model.persons.employee.Contract;
import com.solvd.persistence.connection.ConnectionPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class ContractRepositoryImpl implements ContractRepository {

    @Override
    public void create(Contract contract) {
        Connection connection = ConnectionPool.get();
        try(PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO rental.contract (Start_Contract, End_Contract, Salary) VALUES (?, ?, ?)"
        )) {
            preparedStatement.setObject(1, contract.getStartContract());
            preparedStatement.setObject(2, contract.getEndContract());
            preparedStatement.setBigDecimal(3, contract.getSalary());
        } catch (SQLException e) {
            throw new RuntimeException("Unable to create contract", e);
        } finally {
            ConnectionPool.releaseConnection(connection);
        }
    }

    @Override
    public Optional<Contract> findById(Long id) {
        Connection connection = ConnectionPool.get();
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM rental.contract WHERE id = ?"
        )) {
            preparedStatement.setLong(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(new Contract(resultSet.getLong(1),
                            resultSet.getTimestamp(2).toLocalDateTime(),
                            resultSet.getTimestamp(3).toLocalDateTime(),
                            resultSet.getBigDecimal(4)));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Contract not found", e);
        } finally {
            ConnectionPool.releaseConnection(connection);
        }
        return Optional.empty();
    }
}