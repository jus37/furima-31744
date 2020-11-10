class BuyersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    if current_user.id = @item.user.id
      redirect_to root_path
      return
    end
    @buy_information = BuyInformation.new
  end


  def create
    @item = Item.find(params[:item_id])
    @buy_information = BuyInformation.new(address_params)
    if @buy_information.valid? 
      pay_item
      @buy_information.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:buy_information).permit(:postnumber, :telephonenumber, :area_id, :area_town, :area_street, :building_name).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end

end
