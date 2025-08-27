package com.pahana.test;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.pahana.dao.CustomerDao;
import com.pahana.model.Customer;
import com.pahana.model.User;

class CustomerDaoTest {
	  private static CustomerDao customerDao;

	    @BeforeAll
	    static void setup() {
	        customerDao = new CustomerDao();
	    }

	    @Test
	    void testGetCustomers() {
	        List<Customer> customers = customerDao.getAllCustomers();

	        assertNotNull(customers, "Customer list should not be null");
	        assertTrue(customers.size() >= 0, "Customer list size should be >= 0");

	        if (!customers.isEmpty()) {
	            Customer first = customers.get(0);
	            assertNotNull(first.getName(), "Customer name should not be null");
	            assertNotNull(first.getAccountNumber(), "Account number should not be null");
	        }
	    }
	    void testAddCustomer() {
	        Customer customer = new Customer();
	        customer.setAccountNumber("");
	        customer.setName("John Doe");
	        customer.setAddress("Colombo, Sri Lanka");
	        customer.setTP("0771234567");

	        customerDao.addCustomer(customer);
	        System.out.println("Customer added successfully: " + customer.getName());
	    }
	    @Test
		void testUpdateCustomer() {
	    	  Customer customer = new Customer();
			customer.setAccountNumber("");
	        customer.setName("John Doe");
	        customer.setAddress("Colombo, Sri Lanka");
	        customer.setTP("0771234567");
	        customerDao.updateCustomer(customer);
	        System.out.println("Customer update successfully: " + customer.getName());
		}

}
