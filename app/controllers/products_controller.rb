class ProductsController < ApplicationController
  def new
  end

  def index
	  @products = Product.order(:item)
	  respond_to do |format|
	    format.html
	    format.csv { send_data @products.to_csv }
	    format.xls #{ send_data @products.to_csv(col_sep: "\t") }
	  end
	end

	def import
	  Product.import(params[:file])
	  flash[:success] = "Products imported."
	  redirect_to products_url
	end
end
