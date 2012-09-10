package com.tquila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tquila.domain.Item_types;
import com.tquila.repository.Item_typesRepository;

@Service
public class Item_typeService {
	@Autowired
	private Item_typesRepository itemTypeRepository;	
	
	public Item_types create(Item_types item_Types) {
		return itemTypeRepository.save(item_Types);
	}
	
	public Item_types read(String id) {
		Item_types item_Types = itemTypeRepository.findById(id);
		return item_Types;
	}

	public List<Item_types> readAll() {
		return itemTypeRepository.findAll();
	}
	
	public Item_types update(Item_types item_Type) {
		Item_types existingItemType = itemTypeRepository.findById(item_Type.getId());
		if (existingItemType == null) {
			return null;
		}
		existingItemType.setDescription(item_Type.getDescription());
		existingItemType.setName(item_Type.getName());
		
		return itemTypeRepository.save(existingItemType);
	}
	
	public Boolean delete(Item_types item_Type) {
		Item_types existingItemType = itemTypeRepository.findByName(item_Type.getName());

		if (itemTypeRepository == null) {
			return false;
		}
		
		itemTypeRepository.delete(existingItemType);
		return true;
	}
}
