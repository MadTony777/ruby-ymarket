require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'
require 'page-object'
require 'logger'
require_relative '../../features/step_definitions/pages/DefaultPage'
require_relative '../../features/step_definitions/pages/FilterPage'
require_relative '../../features/step_definitions/pages/MainPage'
require_relative '../../features/step_definitions/pages/ProductPage'

class Test
#   Selenium::WebDriver::Chrome::Service.driver_path = 'C:/Users/user/RubymineProjects/ymarket/ymarket/features/support/drivers/chromedriver.exe'
#   $driver = Selenium::WebDriver.for :chrome
#   $driver.manage.window.maximize
#   $driver.manage.timeouts.implicit_wait=(15)
#
#   default = DefaultPage.new
#   main = MainPage.new
#   filter = FilterPage.new
#   product = ProductPage.new
#   main.open_url('https://market.yandex.ru/catalog--smartfony/26893750/list?hid=91491&local-offers-first=0')
#
#   $logger = Logger.new(STDOUT)
#   $logger.info($driver.current_url)
#
#   default.find_element(xpath: "//*[contains(text(), 'Смартфон ')]")
#
#   puts 'нашел!'
#
# #  default.excplicit_element_visible(xpath: "//*[contains(text(), 'Смарedfgтфон ')]")
#
#
#   sleep(30)
#
# #  $driver.manage.timeouts.implicit_wait=(15)
#
#   puts default.find_element(xpath: "//*[contains(text(), 'Смартфон ')]")


end