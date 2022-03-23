Given(/^Open smartphones category$/) do
  open_smart_category('https://market.yandex.ru/', 'смартфоны')
end

Then(/^Verify that it is smartphones category$/) do
  expect(find_element(class: '_3wPGp').text).to eq('Смартфоны')
end

When(/^Insert price from "(.*)"$/) do |from|
  set_price_from(from)
end

Then(/^Verify that price from is set "(.*)"$/) do |from|
  expect(find_element(id: 'glpricefrom').attribute('value')).to eq(from.to_s)
end

When(/^Insert price to "(.*)"$/) do |to|
  set_price_from(to)
end

Then(/^Verify that price to is set "(.*)"$/) do |to|
  expect(find_element(id: 'glpriceto').attribute('value')).to eq(to.to_s)
end


And(/^Verify all prices in filter range from "(.*)" to "(.*)"$/) do |from, to|
  array = get_products_prices
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    expect((from..to).include?(element.to_i)).to eq(true)
  end
end

And(/^Save url and open it$/) do
  new_url = driver.current_url
  open_url(new_url)
end

When(/^Insert battery capacity "(.*)"$/) do |range|
  array = range.split('-')
  set_battery_filter("#{array[0]}-#{array[1]}")
end

Then(/^Verify that there is no products in list$/) do
  expect(element_exist(xpath: "//*[contains(text(), 'Нет подходящих товаров')]")).to be true or expect(element_exist(xpath: "//*[contains(text(), 'Таких товаров нет, увы')]")).to be true
end

Then(/^Verify that battery capacity is set "(.*)"$/) do |accum|
  is_checked = find_element(xpath: "//span[text()='#{accum} мА⋅ч']/parent::*/preceding::*[1]").attribute('checked')
  raise StandardError, 'Check-box not checked!' if is_checked.eq('')
  expect(is_checked.to_s).to be true
end

And(/^Verify all battery capacity on page in filter range "(.*)"$/) do |range|
#  logger.info($driver.current_url)
  array = range.split('-')
  elements = find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    i.click
    sleep(3)
    accum = get_accum_on_page.to_s
    rangeArr = (array[0]..array[1]).to_a
    if rangeArr.include? accum.to_i
      switch_last_tab
      close_tab
      switch_first_tab
    else
      raise StandardError, 'Incorrect battery capacity!'
    end
    expect(rangeArr).to include(accum)
  end
end

And(/^Verify all battery capacity not in filter range "(.*)"$/) do |range|
  array = range.split('-')
  elements = find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    i.click(xpath: "//*[contains(text(), 'Смартфон ')]")
    accum = get_accum_on_page.to_i
    break if accum < array[0] | accum > array[1]
  end
end

And(/^Verify all battery capacity on all pages in filter range "(.*)"$/) do |range|
  array = range.split('-')
  elements = find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    i.click
    sleep(3)
    accum = get_accum_on_page.to_s
    range_arr = (array[0]..array[1]).to_a
    if range_arr.include? accum.to_i
      switch_last_tab
      close_tab
      switch_first_tab
    else
      raise StandardError, 'Incorrect battery capacity!'
    end
  end
  while element_exist(css: "[aria-label='Следующая страница']")
    next_page
    sleep(3)
    elements = find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
    elements.each do |i|
      i.click
      sleep(3)
      accum = get_accum_on_page.to_s
      range_arr = (array[0]..array[1]).to_a
      if range_arr.include? accum.to_i
        switch_last_tab
        close_tab
        switch_first_tab
      else
        raise StandardError, 'Incorrect battery capacity!'
      end
    end
  end
end

And(/^Verify all prices on all page in filter range from "(.*)" to "(.*)"$/) do |from, to|
  array = get_products_prices
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    expect((from..to).to_a).to include(element)
  end
  while element_exist(css: "[aria-label='Следующая страница']")
    next_page
    sleep(3)
    array = get_products_prices
    array.each do |i|
      element = i.text.gsub(/\s/, '')
      expect((from..to).to_a).to include(element)
    end
  end
end

Then(/^Verify that price from is not set "(.*)"$/) do |value|
  if find_elements(id: 'glpricefrom').text == value
    raise StandardError, 'Incorrect behavior: you can use only numbers in field price from!'
  else
    expect(find_elements(id: 'glpricefrom').text).to eq('')
  end
end

Then(/^Verify that price to is not set "(.*)"$/) do |value|
  if find_elements(id: 'glpriceto').text == value
    raise StandardError, 'Incorrect behavior: you can use only numbers in field price to!'
  else
    expect(find_elements(id: 'glpriceto').text).to eq('')
  end
end

When(/^Click clear button price "(.*)"$/) do |arg|
  click(css: "[aria-label='Очистить поле Цена #{arg}']")
end

Then(/^Verify that price "(.*)" from was cleared$/) do |value|
  if find_elements(id: 'glpricefrom').text == value
    raise StandardError, 'Incorrect behavior: field price from was not cleared!'
  else
    expect(find_elements(id: 'glpricefrom').text).to eq('')
  end
end

Then(/^Verify that price "(.*)" to was cleared$/) do |value|
  if find_elements(id: 'glpriceto').text == value
    raise StandardError, 'Incorrect behavior: field price to was not cleared!'
  else
    expect(find_elements(id: 'glpriceto').text).to eq('')
  end
end

Then(/^Verify that previous count equal to product list count$/) do
  previous = find_element(xpath: "//*[starts-with(text(), 'Найдено ')]").text
  previuos_count = previous.scan(/\d*/).join('')
  actual_count = get_products_prices.length
  expect(previuos_count).to eq(actual_count)
end

And(/^Verify that products not in filer price from "(.*)" range$/) do |from|
  array = get_products_prices
  any_price = nil
  array.each do |i|
    element = i.text.gsub(/\s/, '').to_i
    if element < from
      any_price = element
      break
    end
  end
  expect(any_price).not_to be_nil
end

And(/^Verify that products not in filer price to "(.*)" range$/) do |to|
  array = get_products_prices
  any_price = nil
  array.each do |i|
    element = i.text.gsub(/\s/, '').to_i
    if any_price > to
      any_price = element
      break
    end
  end
  expect(any_price).not_to be_nil
end