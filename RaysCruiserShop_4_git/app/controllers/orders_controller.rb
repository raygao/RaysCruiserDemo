require 'pp'
require 'time'
require 'httparty'
require Rails.root.join('lib','calculator.rb')
class OrdersController < ApplicationController

  before_filter :init

  def init
     sfdcauth()
  end

  # chatter update
  def chatter_update
    question = params[:Question]
    @order = Order.find(params[:order_id])
    post_to_chatter(@client, Salesforce::Cruiser_Order__c.find(@order.sf_cruiser_order_id), question)

    redirect_to order_path(@order)
  end

  # calculate the total book price of the order
  def calculate_price(order_id)
    @book_amount = Calculator.calculate_order_price(order_id)
  end

  # Show Delivery date
  def show_delivery
    order_id = params[:order_id]
    url = SiteConfig[:sap_server][:host] + ":" + SiteConfig[:sap_server][:port] + "/RaysCruiserERP/orders/show_delivery/" + order_id
    # TODO change to use HTTParty
    logger.info("url is #{url}")
    response = HTTParty.get(url).body
    render :text => response
  end

  # GET /order/id/sumbmit
  def submit
    @order = Order.find(params[:order_id])

    neworder = Salesforce::Cruiser_Order__c.new()

    neworder.Name = @order.name
    # cannot reference converted lead. TODO move it to the Contact.

    if (Salesforce::Lead.find(current_user.sf_lead_id).IsConverted)
      # If a Salesforce Lead has been converted, it can no longer be referenced.
      # Hence, must use the Contact as the lookup mechanism.  This only matters on the Salesforce Side and not here.
      neworder.Cruise_Order_to_Contact__c =  Salesforce::Lead.find(current_user.sf_lead_id).ConvertedContactId
    else
      # 1st time, it will be linked to an unconverted Lead
      neworder.Cruiser_Order_to_Lead__c = current_user.sf_lead_id
    end

    neworder.OwnerId = @client.user_id   # This is the OwnerID, who creates this Object in SF
    neworder.Book_Amount__c = calculate_price(@order.id)

    neworder.save()

    #follow this new Order with Chatter
     me = Databasedotcom::Chatter::User.find(@client, 'me')
     me.follow(neworder.Id)
    # post to Chatter as well.
    post_to_chatter(@client, neworder, 'New Order received.')

    @order.update_attributes({submitted: true, sf_cruiser_order_id: neworder.Id})

     redirect_to order_path (@order)
  end

  # GET /orders
  # GET /orders.json
  def index

    @orders = current_user.orders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    enforce_view_permission(@order)
    calculate_price(@order.id)

    unless  @order['sf_cruiser_order_id'].nil?
      @feed_items = Databasedotcom::Chatter::RecordFeed.find(@client, @order.sf_cruiser_order_id)
        #Databasedotcom::Chatter::RecordFeed.find(@client, @order_id)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/#/order_items
  # TODO need to fix it.
  # GET /orders/#/order_items.json
  def manage_details
    @order = Order.find(request[:order_id])
    @order_items = @order.order_items.all
    @available_items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_items }
    end

  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    @order.owner = current_user
    enforce_create_permission(@order)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    enforce_update_permission(@order)
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    enforce_create_permission(@order)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    enforce_update_permission(@order)

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    enforce_destroy_permission(@order)
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
