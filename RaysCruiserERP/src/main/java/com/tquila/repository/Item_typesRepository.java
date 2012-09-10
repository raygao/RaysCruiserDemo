package com.tquila.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.tquila.domain.Item_types;

public interface Item_typesRepository extends MongoRepository<Item_types, String> {
	
	Item_types findByName(String name);
	Item_types findById(String id);
}