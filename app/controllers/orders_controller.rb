class OrdersController < ApplicationController	

	def index
		@orders=create_order_output_table
		@order_contents = OrderContent.all
		render :layout => false
	end

	def put_pro_in_order
		order_content= OrderContent.new
		order_content.order_id=params['order_id']
		order_content.pro_id=params['pro_id']
		order_content.pro_quantity=1
		test=order_content.save
		redirect_to put_pro_in_order_get_path(params[:order_id]), notice: 'Produkt wurde erfolgreich hinzugefügt'
	end

	def save_order
		order=params['order_hash']['order_id']
		order_db = Order.find_by(id: order['order_id'])
		order_db.update(order_status: order['order_status'])
		test = order_db.update(amount: order['price'])

		order['content'].each do |content|
			tmp=content[1]
			order_content_db = OrderContent.find(tmp['id'])
			order_content_db.pro_quantity = tmp['quantity']
			order_content_db.save
		end



		redirect_to dash_board_path
	end


	def prepare_order
		order = Order.find(params[:id])
		@order = Array.new
		@order<<get_order_details(order)	
	end

	def add_pro_to_order
		@products = Product.all
		@order_id= params[:format]
		render :layout => false
	end

	def delete_order
		Order.delete(params[:order_id])
		redirect_to dash_board_path
		#render :layout => false

	end

	private





	def create_order_output_table()
		orders = Order.all 
		return_array = Array.new
		orders.each do |order| 
			return_array<<get_order_details(order)
		end
		return return_array
	end


	def get_order_details(order)
		order_hash=Hash.new
		order_hash[:customer] = User.find(order.customer_id).email
		order_hash[:payment] = PaymentMethod.find(order.payment_id).payment_name
		order_hash[:order_id]=order.id
		order_hash[:order_status]=order.order_status
		order_hash[:amount]= number_to_currency(order.amount)
		order_hash[:order_content] = Hash.new
		order_hash[:order_content] = create_order_content_for_table(order.id)
		return order_hash
	end

	def number_to_currency(price)
		return "#{price} Euro"
	end

	def create_order_content_for_table(order_id)
		orders_content = OrderContent.where(order_id: order_id)
		return_array=Array.new
		orders_content.each do |order_content|
			order_content_hash= Hash.new
			order_content_hash[:id] = order_content.id
			order_content_hash[:quantity]=order_content.pro_quantity
			order_content_hash[:product_name]=Product.find(order_content.pro_id).name
			return_array<<order_content_hash	
		end

		return return_array
	end
end
