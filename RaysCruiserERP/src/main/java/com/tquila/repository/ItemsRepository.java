package com.tquila.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.tquila.domain.Items;


public interface ItemsRepository extends MongoRepository<Items, String> {
	
	Items findByName(String name);
	Items findById(String id);
}
