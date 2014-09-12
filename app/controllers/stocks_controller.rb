class StocksController < ApplicationController

	def delete_pro_from_stock
		session[:stock].delete(params[:id])
		redirect_to add_pro_to_stock_path(pro_id: '#'),
		notice: "Product #{params[:id]} wurde erfolgreich aus Ihrem Warenkorb gelöscht.",style: "background-color:red"
	end


	def add_pro_to_stock
		clear_session_products
		session[:stock]=Array.new if session[:stock].nil?
		session[:stock]<<params[:pro_id] unless params[:pro_id].nil?
		@stock_products = Product.where(id: session[:stock])
	end


	private

	def clear_session_products
		unless session[:stock_products].nil? 
			session[:stock_products]=nil
		end	
	end
end
