package com.tquila.domain;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Orders {
	@Id
	private String id;
	private String description;
	private String name;	
	private String sf_cruiser_order_id; // This will be the one stored in Salesforce
	private String owner_id; // this will be a @DBRef -> Users
	private Boolean submitted;
	private Date delivery_date;
	
	//Define MongoDB name & suffixing 's' without renaming class with 's'
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	public Boolean getSubmitted() {
		return submitted;
	}
	public void setSubmitted(Boolean submitted) {
		this.submitted = submitted;
	}
	public String getSf_cruiser_order_id() {
		return sf_cruiser_order_id;
	}
	public void setSf_cruiser_order_id(String sf_cruiser_order_id) {
		this.sf_cruiser_order_id = sf_cruiser_order_id;
	}
	public Date getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(java.util.Date date) {
		this.delivery_date = date;
	}

}
