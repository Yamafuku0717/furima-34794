class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :search_item, only: [:index, :show ,:search]

  def index
    @items = Item.order('created_at DESC')
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result
    @category = Category.where.not(id: 1)
    @sales_status = SalesStatus.where.not(id: 1)
    @shipping_free_status = ShippingFreeStatus.where.not(id: 1)
    @prefecture = Prefecture.where.not(id: 1)
    @scheduled_delivery = ScheduledDelivery.where.not(id: 1)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :sales_status_id, :shipping_free_status_id,
                                 :prefecture_id, :scheduled_delivery_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @item.user.id && @item.purchase.nil?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search_item
    @p = Item.ransack(params[:q])
  end

end
