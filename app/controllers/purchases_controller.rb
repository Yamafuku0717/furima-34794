class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def move_to_index
    item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id == item.user.id
      redirect_to root_path
    end
  end
end
