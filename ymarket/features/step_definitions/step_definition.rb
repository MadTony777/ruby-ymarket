default = DefaultPage.new
product = ProductPage.new
main = MainPage.new
filter = FilterPage.new

Given(/^Open smartphones category$/) do
  main.open_category('https://market.yandex.ru/', 'Смартфоны')
end

Then(/^Verify that it is smartphones category$/) do
  $wait.until { default.element_exist(css: "[data-grabber='SearchTitle'] h1") }
  expect(default.find_element(css: "[data-grabber='SearchTitle'] h1").text).to eq('Смартфоны')
end

When(/^Insert price from "(.*)"$/) do |from|
  $wait.until { default.element_exist(id: 'glpricefrom') }
  filter.set_price_from(from)
end

Then(/^Verify that price from is set "(.*)"$/) do |from|
  $wait.until { default.element_exist(id: 'glpricefrom') }
  expect(default.find_element(id: 'glpricefrom').attribute('value')).to eq(from.to_s)
end

When(/^Insert price to "(.*)"$/) do |to|
  $wait.until { default.element_exist(id: 'glpriceto') }
  filter.set_price_to(to)
end

Then(/^Verify that price to is set "(.*)"$/) do |to|
  $wait.until { default.element_exist(id: 'glpriceto') }
  expect(default.find_element(id: 'glpriceto').attribute('value')).to eq(to.to_s)
end

And(/^Verify all prices in filter range from "(.*)" to "(.*)"$/) do |from, to|
  puts('step 0')
  $wait.until { default.page_loading }
  puts('step 1')
  array = filter.get_products_prices
  expect(array.count).not_to be_nil
  ar_range = (from..to).to_a
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    expect(ar_range).to include(element)
  end
end

And(/^Save url and open it$/) do
  new_url = $driver.current_url
  default.open_url(new_url)
  click(class: "CheckboxCaptcha-Button") if default.element_exist(xpath: "//*[contains(text(), 'Подтвердите, что запросы отправляли вы, а не робот')]")
end

When(/^Insert battery capacity "(.*)"$/) do |range|
  array = range.split('-')
  filter.set_battery_filter("#{array[0]}-#{array[1]}")
end

Then(/^Verify that battery capacity is set "(.*)"$/) do |accum|
  is_checked = default.find_element(xpath: "//span[text()='#{accum} мА⋅ч']/parent::*/preceding::*[1]").attribute('checked')
  expect(is_checked).to eq('true')
end

And(/^Verify all battery capacity on page in filter range "(.*)"$/) do |range|
  $wait.until { default.page_loading }
  array = range.split('-')
  range_arr = (array[0]..array[1]).to_a
  elements = default.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    $driver.action.move_to(i).click.perform
    default.switch_last_tab
    break if default.element_exist(xpath: "//*[contains(text(), 'Нет в продаже')]")
    $wait.until { default.element_exist(xpath: "//*[contains(text(), 'мА·ч')]") }
    accum = product.get_accum_on_page.to_s
    if range_arr.include? accum
      default.close_tab
      default.switch_first_tab
    else
      raise StandardError, 'Incorrect battery capacity!'
    end
    expect(range_arr).to include(accum)
  end
end

And(/^Verify all battery capacity not in filter range "(.*)"$/) do |range|
  array = range.split('-')
  elements = default.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    $driver.action.move_to(i).click.perform
    accum = product.get_accum_on_page
    break if accum.to_i < array[0].to_i || accum.to_i > array[1].to_i
  end
end

And(/^Verify all battery capacity on all pages in filter range "(.*)"$/) do |range|
  $wait.until { default.page_loading }
  array = range.split('-')
  range_arr = (array[0]..array[1]).to_a
  elements = default.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  elements.each do |i|
    $driver.action.move_to(i).click.perform
    default.switch_last_tab
    $wait.until { default.element_exist(xpath: "//*[contains(text(), 'мА·ч')]") }
    break if default.element_exist(xpath: "//*[contains(text(), 'Нет в продаже')]")
    accum = product.get_accum_on_page.to_s
    if range_arr.include? accum
      default.close_tab
      default.switch_first_tab
    else
      raise StandardError, 'Incorrect battery capacity!'
    end
    expect(range_arr).to include(accum)
  end
  while default.element_exist(css: "[aria-label='Следующая страница']")
    filter.next_page
    $wait.until { default.page_loading }
    array = range.split('-')
    range_arr = (array[0]..array[1]).to_a
    elements = default.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
    elements.each do |i|
      $driver.action.move_to(i).click.perform
      default.switch_last_tab
      $wait.until { default.element_exist(xpath: "//*[contains(text(), 'мА·ч')]") }
      break if default.element_exist(xpath: "//*[contains(text(), 'Нет в продаже')]")
      accum = product.get_accum_on_page.to_s
      if range_arr.include? accum
        default.close_tab
        default.switch_first_tab
      else
        raise StandardError, 'Incorrect battery capacity!'
      end
      expect(range_arr).to include(accum)
    end
  end
end

And(/^Verify all prices on all page in filter range from "(.*)" to "(.*)"$/) do |from, to|
  $wait.until { default.page_loading }
  array = filter.get_products_prices
  expect(array.count).not_to be_nil
  ar_range = (from..to).to_a
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    expect(ar_range.include?(element)).to be true
  end
  while default.element_exist(css: "[aria-label='Следующая страница']")
    filter.next_page
    $wait.until { default.page_loading }
    array = filter.get_products_prices
    expect(array.count).not_to be_nil
    ar_range = (from..to).to_a
    array.each do |i|
      element = i.text.gsub(/\s/, '')
      expect(ar_range).to include(element)
    end
  end
end

Then(/^Verify that price from is not set "(.*)"$/) do |value|
  if default.find_element(id: 'glpricefrom').text == value
    raise StandardError, 'Incorrect behavior: you can use only numbers in field price from!'
  else
    expect(default.find_element(id: 'glpricefrom').text).to eq('')
  end
end

Then(/^Verify that price to is not set "(.*)"$/) do |value|
  if default.find_element(id: 'glpriceto').text == value
    raise StandardError, 'Incorrect behavior: you can use only numbers in field price to!'
  else
    expect(default.find_element(id: 'glpriceto').text).to eq('')
  end
end

When(/^Click clear button price "(.*)"$/) do |arg|
  default.click(css: "[aria-label='Очистить поле Цена #{arg}']")
end

Then(/^Verify that price "(.*)" from was cleared$/) do |value|
  if default.find_element(id: 'glpricefrom').text == value.to_s
    raise StandardError, 'Incorrect behavior: field price from was not cleared!'
  else
    expect(default.find_element(id: 'glpricefrom').text).to eq('')
  end
end

Then(/^Verify that price "(.*)" to was cleared$/) do |value|
  if default.find_element(id: 'glpriceto').text == value.to_s
    raise StandardError, 'Incorrect behavior: field price to was not cleared!'
  else
    expect(default.find_element(id: 'glpriceto').text).to eq('')
  end
end

Then(/^Verify that previous count equal to product list count$/) do
  $wait.until { default.element_exist(xpath: "//*[contains(text(), 'Найдено')]") }
  previous = default.find_element(xpath: "//*[contains(text(), 'Найдено')]").text
  previuos_count = previous.scan(/\d*/).join('')
  default.find_element(css: "[data-zone-name='price'] [data-autotest-currency] span:first-of-type")
  actual_count = filter.get_products_prices
  expect(actual_count.count).not_to be_nil
  expect(previuos_count.to_i).to eq(actual_count.count)
end

And(/^Verify that products not in filer price from "(.*)" range$/) do |from|
  array = filter.get_products_prices
  any_price = nil
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    if element < from
      any_price = element
      break
    end
  end
  expect(any_price).not_to be_nil
end

And(/^Verify that products not in filer price to "(.*)" range$/) do |to|
  $wait.until { default.page_loading }
  array = filter.get_products_prices
  any_price = nil
  array.each do |i|
    element = i.text.gsub(/\s/, '')
    if to < element
      any_price = element
      break
    end
  end
  expect(any_price).not_to be_nil
end

Then(/^Verify that there is no products in list$/) do
  $wait.until { default.element_exist(xpath: "//*[contains(text(), 'Найдено')]") }
  expect(default.element_exist(xpath: "//*[contains(text(), 'Таких товаров нет, увы')]")).to be true
end

And(/^Verify that poduct list not empty$/) do
  $wait.until { default.element_exist(xpath: "//*[contains(text(), 'Найдено')]") }
  expect(default.element_exist(xpath: "//*[contains(text(), 'Таких товаров нет, увы')]")).to be false
end