class OrderItemsController < ApplicationController
  # GET /orders/#/order_items
  # GET /orders/#/order_items.json

  before_filter :init

  def init
     #client = sfdcauth()
  end

  def calculate_price(order_id)
    @book_amount = Calculator.calculate_order_price(order_id)
  end


  def index
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items.all
    @available_items = Item.all
    @book_amount = calculate_price(@order.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_items }
    end
  end

  # GET /orders/#/order_items/1
  # GET /orders/#/order_items/1.json
  def show
    @order = Order.find(request[:order_id])
    @order_item = @order.order_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_item }
    end
  end

  # GET /orders/#/order_items/new
  # GET /orders/#/order_items/new.json
  def new
    @order = Order.find(request[:order_id])
    @order_item = @order.order_items.new
    @order_item.owner = current_user
    item_id = request[:item_id]
    unless item_id.nil?
      @order_item.item_id = item_id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_item }
    end
  end

  # GET /orders/#/order_items/1/edit
  def edit
    @order = Order.find(request[:order_id])
    @order_item = OrderItem.find(params[:id])
  end

  # POST /orders/#/order_items
  # POST /orders/#/order_items.json
  def create
    @order = Order.find(request[:order_id])
    @order_item = OrderItem.new(params[:order_item])
    @order_item.order_id = @order.id
    @order_item.owner = current_user

    respond_to do |format|
      #if @order.order_items.push(@order_item)
      result = @order_item.save()
      if result
        format.html { redirect_to [@order, @order_item], notice: "This item was successfully added to '#{@order.name}'." }
        format.json { render json: @order_item, status: :created, location: @order_item }
      else
        format.html { render action: "new" }
        format.json { render json: @order.order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order/#/order_items/1
  # PUT /order/#/order_items/1.json
  def update
    @order = Order.find(request[:order_id])
    @order_item = @order.order_items.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to [@order, @order_item], notice: 'Order Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order/#/order_items/1
  # DELETE /order/#/order_items/1.json
  def destroy
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to order_order_items_url }
      format.json { head :no_content }
    end
  end
end
