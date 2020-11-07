require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '出品登録がうまくいくとき' do
      it '全項目が正しく入力されている' do
        expect(@item).to be_valid
      end
      it 'category_id,status_id,cost_id,area_id,send_day_idのidが0以外である' do
        @item.category_id = '1'
        @item.status_id = '1'
        @item.cost_id ='1'
        @item.area_id = '1'
        @item.send_day_id = '1'
        expect(@item).to be_valid
      end
      it '金額が300~9,999,999円で入力されている' do
        @item.price = "1000"
        expect(@item).to be_valid
      end
    end
    context '出品登録がうまくいかないとき' do
      it '画像が添付されていない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '名前が空白である' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '説明文が空白である' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'カテゴリーが"---"を選んでいる' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it '商品状態が"---"を選んでいる' do
        @item.status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 0")
      end
      it '送料が"---"を選んでいる' do
        @item.cost_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost must be other than 0")
      end
      it '発送地域が"---"を選んでいる' do
        @item.area_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Area must be other than 0")
      end
      it '発送日が"---"を選んでいる' do
        @item.send_day_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Send day must be other than 0")
      end
      it '金額が入力されていない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number", "Price 半角で入力してください")
      end 
      it '金額が300円未満である' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end      
      it '金額が9,999,999円より大きい' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end      
      it '金額が半角で入力されていない' do
        @item.price = '１００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end      
      it '金額が数字以外で入力されている' do
        @item.price = 'ﾔﾏﾀﾞ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end      
    end
  end
end
