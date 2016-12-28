class Admin::ProductsController < Admin::BaseController

  before_action :load_product, except: [:index, :new, :create]

  def index
    @products = Product.search_product params[:search]
      .paginate page: params[:page], per_page: Settings.per_page 
  end

  def new
    @category = Category.find_by id: params[:category_id]
    if @category
      @product = Product.new
    else
      render file: Settings.page_404_url 
    end
  end

  def edit 
  end

  def update 
    if @product.update_attributes product_params
       flash[:success] = t ".update_success"
       redirect_to admin_categories_path
    else
       flash[:notice] = t".update_fail"
       redirect_to :back
    end
  end

  def show
  end

  def create
    @product = Product.new product_params
    respond_to do |format|
      if @product.save
        format.html {redirect_to admin_category_url params[:product][:category_id], 
          notice: t(".product_successfully_created")}
      else
        format.html {render :new}
      end
    end
  end

  def destroy
    if @product.destroy
      respond_to do |format|
        format.html {redirect_to products_url}
        format.json {head :no_content}
        format.js   {render layout: false}
      end
    else
      flash[:danger] = t ".delete_error"
      redirect_to :back
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    render file: Settings.page_404_url unless @product
  end

  def product_params
    params.require(:product)
      .permit :productname, :productPrice, :productStatus,:productDescription, 
        :rate, :upPicture, :category_id
  end
end
