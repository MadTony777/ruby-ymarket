require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'
require 'page-object'
require_relative '../../features/step_definitions/pages/DefaultPage'
require_relative '../../features/step_definitions/pages/FilterPage'
require_relative '../../features/step_definitions/pages/MainPage'
require_relative '../../features/step_definitions/pages/ProductPage'

class Test
  Selenium::WebDriver::Chrome::Service.driver_path = 'C:/Users/user/RubymineProjects/ymarket/ymarket/features/support/drivers/chromedriver.exe'
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.window.maximize

  default = DefaultPage.new
  main = MainPage.new
  filter = FilterPage.new
  product = ProductPage.new
  main.open_url('https://market.yandex.ru/catalog--smartfony/26893750/list?hid=91491&local-offers-first=0')
  puts 'fall 2'

  sleep(3)
  range = "1000-1999"
  filter.set_battery_filter(range)
  puts 'fall 3'
  sleep(10)

  array = range.split('-')
  elements = main.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")

  elements.each do |i|
    i.click
    sleep(3)
    $driver.switch_to.window($driver.window_handles.last)
    accum = product.get_accum_on_page.to_s
    puts 'capacity is: ' + accum
    rangeArr = (array[0]..array[1]).to_a
    sleep(3)
    if rangeArr.include? accum
      $driver.close
      $driver.switch_to.window($driver.window_handles.first)
      puts "included"
    else
      raise StandardError, 'Incorrect battery capacity!'
    end
  end


end