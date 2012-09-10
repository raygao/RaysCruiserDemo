package com.tquila.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tquila.domain.Item_types;
import com.tquila.dto.Item_typesListDto;
import com.tquila.service.Item_typeService;


/**
 * Handles requests for the application home page.
 */
@RequestMapping("/item_types")
@Controller
public class Item_typesController {
	
	private static final Logger logger = LoggerFactory.getLogger(Item_typesController.class);
	
	@Autowired
	private Item_typeService service;
	
	/* update Item_types*/
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(
			@RequestParam String id, 
			@RequestParam String name, 
			@RequestParam String description,
			Model model) {	
		logger.info("=== doing Item update with " + id + "===");

		Item_types item_type = service.read(id);
		logger.info("updating " + item_type.getName());
		item_type.setName(name);
		item_type.setDescription(description);

		service.update(item_type);
		
		return show(id, model);
	}
	
	/* edit an Item_types, pre-update */
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") String id, Model model) {
		Item_types item_type = service.read(id);
		model.addAttribute("item_type", item_type);		
		return "item_types/edit";
	}
	
	/* new Item_types, pre-doCreate */
	@RequestMapping(value="/new", method = RequestMethod.GET)
	public String create(Model model) {
		Item_types item_type = new Item_types();
		model.addAttribute("item_type", item_type);
		return "item_types/new";
	}
	
	/* Do creating a new Item_types*/
	@RequestMapping(method = RequestMethod.POST)
	public String doCreate(@RequestParam String name, 
			@RequestParam String description,
			Model model) {
		logger.info("Creating a new item_type: => " + name);
			
		Item_types item_type = new Item_types();
		item_type.setDescription(description);
		item_type.setName(name);

		service.create(item_type);		
		return list(model);
	}
	
	/*delete item method */
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE) 
	public String delete(@PathVariable String id, Model model) 
	{
		Item_types item_type = service.read(id);
		model.addAttribute("item", item_type);
		logger.info("deleting " + item_type.getName());
		
		service.delete(item_type);
		model.addAttribute("notification", "Successfully deleted");

		//go back to listing page
		return list(model);
	}
	
	/* show an Item_types */
	@RequestMapping(value="/{id}", method = RequestMethod.GET)
	public String show(@PathVariable("id") String id, Model model) {
		Item_types item_type = service.read(id);
		model.addAttribute("item_type", item_type);
		return "item_types/show";
	}
		
	/* index of the Item_types controller, show all listings */	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model) {
		logger.info("=== In the ItemtypeController's list ====");	
		
		Item_typesListDto item_TypesListDto = new Item_typesListDto();
		item_TypesListDto.setItem_Types(service.readAll());
		
		logger.info("=== size: " + item_TypesListDto.getItem_Types().size());
		
		model.addAttribute("item_TypesList", item_TypesListDto.getItem_Types());		
		
		// see /WEB-INF/views/tiled-views.xml	
		return "item_types/index";
	}
		
}
