class Admin::CategorysController < Admin::BaseController
	
  def index
    @categorys=Category.all
  end

  def new
	@category = Category.new
  end

  def show
    @category = Category.find_by id: params[:id]
    @products = @category.products.paginate page: params[:page], per_page: Settings.category_per_page 
  end

  def create
    @category = Category.new category_params
	if @category.save
	  redirect_to admin_categorys_url
	else
	  flash[:danger] = t "create_category_fail"
	  render :index
	end
  end

  def destroy
	Category.find_by(id: params[:id]).destroy
	flash[:success] = t "category_deleted"
	redirect_to admin_categorys_url
  end

  private

  def category_params
    params.require(:category).permit :name, :decription
  end
end
