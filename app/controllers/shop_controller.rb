class ShopController < ApplicationController
		
	def index
		@categories = Category.all 
		get_products
	end

	
	def pay_methods
		if session[:stock].nil? || session[:stock].size<1
			redirect_to add_pro_to_stock_path(pro_id:0)
		end
		save_stock
		@pay_methods=PaymentMethod.all
	end


	def shipments
		if session[:stock].nil? || session[:stock].size<1
			redirect_to add_pro_to_stock_path(pro_id:0)
		end
		session[:payment_method]=params[:payment_id]
		@shipments=Shipment.all

		unless session[:amount_flag]==nil
			session[:amount_flag]=nil
		end
	end


	def summary
		unless  user_signed_in? || admin_signed_in?
			redirect_to users_sign_in_path
		end

		session[:shipment]= Shipment.find(params['shipment_id'])
		shipment_cost=session[:shipment].cost;
		if session[:amount_flag]==nil
			session[:amount] +=shipment_cost
			session[:amount_flag]=true 
		end
		session[:shipment_id]=params['shipment_id']
		
		@amount = number_to_currency(session[:amount])
		@shipment = session[:shipment]
		@summary_products=session[:stock_products]
		@pay_method = PaymentMethod.find(session[:payment_method])
	end


	def order_done
		order = Order.new
		order.amount = session[:amount]

		order.customer_id = current_admin.id
		order.payment_id = session[:payment_method]
		order.shipment_id = session[:shipment_id]
		order.order_status=1
		is_order_saved = order.save

		
		session[:stock_products].each do |product|
			order_content = OrderContent.new
			order_content.pro_id=product['id'].to_i
			order_content.order_id=order.id
			order_content.pro_quantity=product['menge']
			is_order_content_saved = order_content.save
		end

		clear_stock
	end


	private

	def clear_stock
		session[:pay_method]=nil
		session[:stock]=nil
		session[:stock_products]=nil
	end

	def number_to_currency(price)
		return "#{price} Euro"
	end


	def save_stock
		session[:stock_products]=Array.new if session[:stock_products].nil?
		session[:amount]=0
		unless request[:pro_hash].nil?
			request[:pro_hash].each do |key, hash|
				product = Hash.new
				product[:id]=key
				basket_pro_id=key
				product[:name] =  hash['name']
				product[:price] = hash['price']
				product[:menge] = Integer(hash['menge'])
				amount  = product[:menge].to_i*product[:price].to_i
				session[:amount] +=amount
				session[:stock_products]<<product
			end
		end
	end


	def get_products
		if params[:cat_id]
			@products = Product.where(cid:params[:cat_id])
		else
			@products = Product.all	
		end
	end
end