require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
             FactoryBot.create(:item, price: 3000)
             FactoryBot.create(:item, price: 1500)
             FactoryBot.create_list(:item, 20)
    @item1 = FactoryBot.create(:item, name: "黒色の帽子",category_id: 2, sales_status_id: 2,
              shipping_free_status_id: 2, prefecture_id: 2,
              price: 500, scheduled_delivery_id: 2 )
  end

  it '検索ワードを入力した状態でボタンを押すと検索結果のページへ移動し、商品が表示される' do
    #トップページに移動する
    visit root_path
    #トップページに検索ボタンがあることを確認する
    expect(page).to have_selector ".search-button"
    #検索ワードを入力しボタンを押すと検索結果のページに遷移する
    fill_in 'search-word', with: "黒色"
    find('button[name="button"]').click
    expect(current_path).to eq(search_items_path)
    #商品名に検索ワードが含まれる商品が表示される
    expect(page).to have_content("黒色")
  end
  it '検索結果ページに表示されている商品をクリックすると商品詳細ページへ遷移する' do
    #トップページに移動する
    visit root_path
    #トップページに検索ボタンがあることを確認する
    expect(page).to have_selector ".search-button"
    #検索ワードを入力しボタンを押すと検索結果のページに遷移する
    fill_in 'search-word', with: "黒色"
    find('button[name="button"]').click
    expect(current_path).to eq(search_items_path)
    #表示されている商品をクリックすると商品詳細ページに遷移する
    find(".item-img").click
    expect(current_path).to eq(item_path(@item1))
  end
  it '検索条件を指定した状態で検索ボタンを押すと対応した商品が表示される' do
    #トップページに移動する
    visit root_path
    #トップページに検索ボタンがあることを確認する
    expect(page).to have_selector ".search-button"
    #ボタンを押すと検索結果のページに遷移する
    find('button[name="button"]').click
    expect(current_path).to eq(search_items_path)
    #「カテゴリー」を選択し、検索ボタンを押すと対応した商品が表示される
    (find('#q_category_id_eq').click).find('option[value="2"]').click #「レディース」を選択
    move_to_result
    expect(page).to have_content("レディース")
    #「商品の状態」を選択し、検索ボタンを押すと対応した商品が表示される
    visit search_items_path
    (find('#q_sales_status_id_eq').click).find('option[value="2"]').click #「新品・未使用」を選択
    move_to_result
    expect(page).to have_content("新品・未使用")
    #「配送料の負担」を選択し、検索ボタンを押すと対応した商品が表示される
    visit search_items_path
    (find('#q_shipping_free_status_id_eq').click).find('option[value="2"]').click #「着払い(購入者負担)」を選択
    move_to_result
    expect(page).to have_content("着払い(購入者負担)")
    #「発送元の地域」を選択し、検索ボタンを押すと対応した商品が表示される
    visit search_items_path
    (find('#q_prefecture_id_eq').click).find('option[value="2"]').click #「北海道」を選択
    move_to_result
    expect(page).to have_content("北海道")
    #「発送までの日数」を選択し、検索ボタンを押すと対応した商品が表示される
    visit search_items_path
    (find('#q_scheduled_delivery_id_eq').click).find('option[value="2"]').click #「1~2日で発送」を選択
    move_to_result
    expect(page).to have_content("1~2日で発送")
    #「価格:1000円以下」を選択し、検索ボタンを押すと価格が1000円以下の商品が表示される
    visit search_items_path
    find('input[value="1000"]').click
    move_to_result
    expect(find('.item-price')['innerHTML'].to_i).to be <= 1000
    #「価格:2500円以下」を選択し、検索ボタンを押すと価格が2500円以下の商品が表示される
    visit search_items_path
    find('input[value="2500"]').click
    move_to_result
    expect(find('.item-price')['innerHTML'].to_i).to be <= 2500
    #「価格:5000円以下」を選択し、検索ボタンを押すと価格が5000円以下の商品が表示される
    visit search_items_path
    find('input[value="5000"]').click
    move_to_result
    expect(find('.item-price')['innerHTML'].to_i).to be <= 5000
  end  
end
