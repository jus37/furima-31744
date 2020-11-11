class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_item

  def index
    unless current_user.id != @item.user.id && @item.buyer.nil?
      redirect_to root_path
      return
    end
    @buy_information = BuyInformation.new
  end

  def create
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

  def get_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end
end
