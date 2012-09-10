package com.tquila.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.tquila.domain.Orders;


public interface OrdersRepository extends MongoRepository<Orders, String> {
	
	Orders findByName(String name);
	Orders findById(String id);
}
