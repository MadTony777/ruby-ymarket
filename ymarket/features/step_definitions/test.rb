require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'
require 'page-object'
require 'logger'
require_relative '../../features/step_definitions/pages/DefaultPage'
require_relative '../../features/step_definitions/pages/FilterPage'
require_relative '../../features/step_definitions/pages/MainPage'
require_relative '../../features/step_definitions/pages/ProductPage'

class Test
  # Selenium::WebDriver::Chrome::Service.driver_path = 'C:/Users/user/RubymineProjects/ymarket/ymarket/features/support/drivers/chromedriver.exe'
  # $driver = Selenium::WebDriver.for :chrome
  # $driver.manage.window.maximize
  # $driver.manage.timeouts.implicit_wait=(15)
  #
  # default = DefaultPage.new
  # main = MainPage.new
  # filter = FilterPage.new
  # product = ProductPage.new
  #  main.open_url('https://market.yandex.ru/catalog--smartfony/26893750/list?hid=91491&local-offers-first=0')
  #
  # sleep(5)
  #
  #
  # puts default.find_element(xpath: "//*[contains(text(), 'Смартфон ')]")
  # range = "1000-1999"
  # array = range.split('-')
  # filter.set_battery_filter("#{array[0]}-#{array[1]}")
  # sleep(5)
  #
  # range_arr = (array[0]..array[1]).to_a
  # elements = default.find_elements(xpath: "//*[contains(text(), 'Смартфон ')]")
  # elements.each do |i|
  #   $driver.action.move_to(i).click.perform
  #   sleep(2)
  #   default.switch_last_tab
  #   accum = product.get_accum_on_page.to_s
  #   puts $driver.current_url
  #   puts 'WTF' + accum
  #   if range_arr.include? accum
  #     puts "include"
  #     default.close_tab
  #     default.switch_first_tab
  #   else
  #     raise StandardError.new('Incorrect battery capacity!')
  #   end
  #   end
  # <span class="_20WYq _2WBB4" role="button" tabindex="0" data-tid="569d74c7">Найдено 40 товаров</span>
end