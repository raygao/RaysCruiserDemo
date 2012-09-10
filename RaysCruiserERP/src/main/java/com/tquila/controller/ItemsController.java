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
import com.tquila.domain.Items;
import com.tquila.dto.ItemsListDto;
import com.tquila.service.ItemService;
import com.tquila.service.Item_typeService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping("/items")
@Controller
public class ItemsController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemsController.class);

	@Autowired
	private ItemService service;

	@Autowired
	private Item_typeService item_typesService;
	
	/* update item*/
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(
			@RequestParam String id, 
			@RequestParam String name, 
			@RequestParam String description,
			@RequestParam String price,
			@RequestParam String quantity,
			Model model) {	
		logger.info("=== doing Item update with " + id + "===");

		Items item = service.read(id);
		logger.info("updating " + item.getName());
		item.setName(name);
		item.setDescription(description);
		item.setPrice(new Integer(price));
		item.setQuantity(new Integer(quantity));
		service.update(item);
		
//		//Item_types item_type = item_typesService.read(item.getItem_type_id());
//		
//		//model.addAttribute("item_type", item_type);		
//		model.addAttribute("item", item);
		return show(id, model);
	}
	
	/* edit an item, pre-update */
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") String id, Model model) {
		Items item = service.read(id);
		Item_types item_type = item_typesService.read(item.getItem_type_id()); 
		model.addAttribute("item_type", item_type);		
		model.addAttribute("item", item);
		return "items/edit";
	}
	
	/* new item, pre-doCreate */
	@RequestMapping(value="/new", method = RequestMethod.GET)
	public String create(Model model) {
		Items item = new Items();
		model.addAttribute("item", item);
		return "items/new";
	}
	
	/* Do creating a new item*/
	@RequestMapping(method = RequestMethod.POST)
	public String doCreate(@RequestParam String name, 
			@RequestParam String description,
			@RequestParam String price,
			@RequestParam String quantity,
			Model model) {
		logger.info("Creating a new item: => " + name);
		
		Items item = new Items();
		item.setDescription(description);
		item.setName(name);
		item.setPrice(new Integer(price));
		item.setQuantity(new Integer(quantity));
		/* TODO item type & Image */
		service.create(item);		
		return list(model);
	}
	
	/*delete item method */
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE) 
	public String delete(@PathVariable String id, Model model) 
	{
		Items item = service.read(id);
		model.addAttribute("item", item);
		logger.info("deleting " + item.getName());
		
		service.delete(item);
		model.addAttribute("notification", "Successfully deleted");

		//go back to listing page
		return list(model);
	}
	
	/* show an item */
	@RequestMapping(value="/{id}", method = RequestMethod.GET)
	public String show(@PathVariable("id") String id, Model model) {
		Items item = service.read(id);
		Item_types item_type = item_typesService.read(item.getItem_type_id()); 
		model.addAttribute("item_type", item_type);		
		model.addAttribute("item", item);
		return "items/show";
	}
	
	/* index of the items controller, show all listings */	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model) {
		logger.info("=== In the ItemController's listing() method ====");

		ItemsListDto itemsListDto = new ItemsListDto();
		itemsListDto.setItems(service.readAll());
		
		logger.info("=== size: " + itemsListDto.getItems().size());
		
		model.addAttribute("itemsList", itemsListDto.getItems());
		
		// see /WEB-INF/views/tiled-views.xml
		return "items/index";
	}
				
}