package com.tquila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tquila.domain.Items;
import com.tquila.repository.ItemsRepository;

@Service
public class ItemService {
	@Autowired
	private ItemsRepository itemsRepository;	
	
	public Items create(Items item) {
		return itemsRepository.save(item);
	}
	
	public Items read(String id) {
		Items item = itemsRepository.findById(id);
		return item;
	}

	public List<Items> readAll() {
		return itemsRepository.findAll();
	}
	
	public Items update(Items item) {
		Items existingItem = itemsRepository.findById(item.getId());
		if (existingItem == null) {
			return null;
		}
		existingItem.setDescription(item.getDescription());
		existingItem.setName(item.getName());
		existingItem.setQuantity(item.getQuantity());
		existingItem.setPrice(item.getPrice());
		
		return itemsRepository.save(existingItem);
	}
	
	public Boolean delete(Items item) {
		Items existingItem = itemsRepository.findByName(item.getName());

		if (itemsRepository == null) {
			return false;
		}
		
		itemsRepository.delete(existingItem);
		return true;
	}

}
