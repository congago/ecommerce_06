class Admin::ProductsController < Admin::BaseController

  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @products=Product.search_product(params[:search])
      .paginate page: params[:page], per_page: Settings.per_page 
  end

  def new
    @category=Category.find_by id: params[:cate_id] unless  params[:cate_id].nil?
    @product = Product.new
  end

  def edit 
    
  end

  def update 
    if @product.update_attributes product_params
      redirect_to admin_categorys_path
    else
      redirect_to root_path
    end
  end

  def show
    
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html {redirect_to admin_category_url(params[:product][:category_id]), 
          notice: t(".product_successfully_created") }
      else
      format.html {render :new}
      end
    end
  end

  def import
    Product.import(params[:file])
    redirect_to products_url
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html {redirect_to products_url}
      format.json {head :no_content}
      format.js   {render :layout => false}
    end
  end

  private

    def load_product
       @product = Product.find(params[:id]) 
    end

    def product_params
      params.require(:product)
        .permit :productname, :productPrice, :productStatus,:productDescription, :rate, :upPicture, :category_id
    end
end
