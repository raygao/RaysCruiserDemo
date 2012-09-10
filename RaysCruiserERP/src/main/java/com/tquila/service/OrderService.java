package com.tquila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tquila.domain.Orders;
import com.tquila.repository.OrdersRepository;

@Service
public class OrderService {
	@Autowired
	private OrdersRepository ordersRepository;	
	
	public Orders create(Orders order) {
		return ordersRepository.save(order);
	}
	
	public Orders read(String id) {
		Orders order = ordersRepository.findById(id);
		return order;
	}

	public List<Orders> readAll() {
		return ordersRepository.findAll();
	}
	
	public Orders update(Orders order) {
		Orders existingOrder = ordersRepository.findById(order.getId());
		if (existingOrder == null) {
			return null;
		}
		existingOrder.setDescription(order.getDescription());
		existingOrder.setName(order.getName());
		// Shouldn't allow people to change the 'sf_cruiser_order_id', 'owner_id', 'submitted'
//		existingOrder.setSf_cruiser_order_id(order.getSf_cruiser_order_id());
//		existingOrder.setOwner_id(order.getOwner_id());
//		existingOrder.setSubmitted(order.getSubmitted());
		existingOrder.setDelivery_date(order.getDelivery_date());
		
		return ordersRepository.save(existingOrder);
	}
	
	public Boolean delete(Orders orders) {
		Orders existingOrderType = ordersRepository.findByName(orders.getName());

		if (ordersRepository == null) {
			return false;
		}
		
		ordersRepository.delete(existingOrderType);
		return true;
	}

}
