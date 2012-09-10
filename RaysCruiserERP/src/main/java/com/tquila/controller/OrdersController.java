package com.tquila.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tquila.domain.Orders;
import com.tquila.dto.OrdersListDto;
import com.tquila.service.OrderService;


/**
 * Handles requests for the application home page.
 */
@RequestMapping("/orders")
@Controller
public class OrdersController {
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersController.class);
	private DateFormat formatter;
	
	@Autowired
	private OrderService service;
	
	/* update Orders*/
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(
			@RequestParam String id, 
			@RequestParam String name, 
			@RequestParam String description,
			@RequestParam String submitted,
			@RequestParam String owner_id,
			@RequestParam String sf_cruiser_order_id,
			@RequestParam String delivery_date,
			Model model) {	
		logger.info("=== doing Order update with " + id + "===");
		
		Orders order = service.read(id);
		logger.info("updating " + order.getName());
		order.setName(name);
		order.setDescription(description);
		// Shouldn't allow people to change the 'sf_cruiser_order_id', 'owner_id', 'submitted'
//		order.setOwner_id(owner_id);
//		order.setSf_cruiser_order_id(sf_cruiser_order_id);
//		order.setSubmitted(new Boolean (submitted));
		try {
			formatter = new SimpleDateFormat("dd-MMM-yy");
			order.setDelivery_date( (Date) formatter.parse(delivery_date));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		service.update(order);
		
		return show(id, model);
	}
	
	/* edit an Orders, pre-update */
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") String id, Model model) {
		Orders order = service.read(id);		
		model.addAttribute("order", order);
		return "orders/edit";
	}
	
	/* set Order delivery date, call update() */
	@RequestMapping(value="/set_delivery/{id}", method = RequestMethod.GET)
	public String set_delivery(@PathVariable("id") String id, Model model) {		
		Orders order = service.read(id);		
		logger.info("Setting delivery date for " + order.getName());
		model.addAttribute("order", order);
		return "orders/set_delivery";
	}
	
	/*show Order Delivery Date */
	@RequestMapping(value="/show_delivery/{id}", method = RequestMethod.GET)
	//@RequestMapping(value="/show_delivery/{id}", method = RequestMethod.GET, produces= "application/json; charset=utf-8")
	@ResponseBody public String show_delivery(@PathVariable("id") String id, Model model) {
		Orders order = service.read(id);
		logger.info("show order delivery date => " + order.getName());
		model.addAttribute("order", order);
		// return order; //This returns a Date in JSON format		
		return order.getDelivery_date().toString(); //This returns a Date in String format 
	}	
	
	/* new Orders, pre-doCreate */
	@RequestMapping(value="/new", method = RequestMethod.GET)
	public String create(Model model) {
		logger.info("== New Order Form generated. ==");
		Orders order = new Orders();
		model.addAttribute("order", order);
		return "orders/new";
	}
	
	/* Do creating a new Orders*/
	@RequestMapping(method = RequestMethod.POST)
	public String doCreate(@RequestParam String name, 
			@RequestParam String description,
			Model model) {
		logger.info("Creating a new order: => " + name);
			
		Orders order = new Orders();
		order.setDescription(description);
		order.setName(name);

		service.create(order);		
		return list(model);
	}
	
	/*delete order method */
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE) 
	public String delete(@PathVariable String id, Model model) 
	{
		Orders order = service.read(id);
		model.addAttribute("order", order);
		logger.info("deleting " + order.getName());
		
		service.delete(order);
		model.addAttribute("notification", "Successfully deleted");

		//go back to listing page
		return list(model);
	}
	
	/* show an Orders */
	@RequestMapping(value="/{id}", method = RequestMethod.GET)
	public String show(@PathVariable("id") String id, Model model) {
		Orders order = service.read(id);
		model.addAttribute("order", order);
		return "orders/show";
	}
		
	/* index of the Orders controller, show all listings */	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model) {
		logger.info("=== In the OrdersController's list ====");	
		
		OrdersListDto ordersListDto = new OrdersListDto();
		ordersListDto.setOrders(service.readAll());
		
		logger.info("=== size: " + ordersListDto.getOrders().size());
		
		model.addAttribute("ordersList", ordersListDto.getOrders());		

		// see /WEB-INF/views/tiled-views.xml
		return "orders/index"; 
	}
	
}
