module SearchSupport
  def move_to_result
    click_on("検索")
    expect(current_path).to eq(search_items_path)
    all('.item-img-content')[0].click
  end
end