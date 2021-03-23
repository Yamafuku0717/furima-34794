require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品の新規出品" do
    context '新規出品できるとき' do
      it '出品画像と商品名、商品の説明とカテゴリー、商品の状態と配送料の負担、発送元の地域と発送までの日数、販売価格が存在していれば登録できること' do
        expect(@item).to be_valid
      end
      it '販売価格が半角数字であれば登録できる' do
        @item.price = 1000
        expect(@item).to be_valid
      end
    end
    context '新規出品できないとき' do
      it '出品画像が存在していない場合登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できないこと' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空では登録できないこと' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーが選択されていない場合登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態が選択されていない場合登録できないこと' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status must be other than 1")
      end
      it '配送料の負担が選択されていない場合登録できないこと' do
        @item.shipping_free_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping free status must be other than 1")
      end
      it '発送元の地域が選択されていない場合登録できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '発送までの日数が選択されていない場合登録できないこと' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery must be other than 1")
      end
      it '販売価格に全角数字が含まれている場合登録できないこと' do
        @item.price = "１１１"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格に記号が含まれている場合登録できないこと' do
        @item.price = '111/.@'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格に全角文字が含まれている場合登録できない' do
        @item.price = "111あああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格に半角文字が含まれている場合登録できないこと' do
        @item.price = '111aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格が300未満では登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '販売価格が10,000,000以上では登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'userが紐付いていなければ登録できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
