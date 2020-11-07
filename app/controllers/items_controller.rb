class ItemsController < ApplicationController
  def index
    @items = Item.order('created_at  DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :price, :category_id, :status_id, :cost_id, :area_id, :send_day_id).merge(user_id: current_user.id)
  end
end
