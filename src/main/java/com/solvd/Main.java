package com.solvd;

import com.solvd.model.persons.customer.Customer;
import com.solvd.service.persons.customer.CustomerService;
import com.solvd.service.persons.customer.CustomerServiceImpl;

public class Main {
    public static void main(String[] args) {
        System.out.println("Test customer");
        CustomerService customerService = new CustomerServiceImpl();
        Customer customer = customerService.loadCustomerById(1L);
        System.out.println(customer.getFirstName());
    }
}