require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'

Before do |scenario|
  #Selenium::WebDriver::Chrome::Service.driver_path = $DRIVER_PATH
  #Selenium::WebDriver::Chrome::Service.driver_path = 'C:/Users/user/RubymineProjects/ymarket/ymarket/features/support/drivers/chromedriver.exe'
  #$driver = Selenium::WebDriver.for :chrome
  #$driver.manage.window.maximize
end

After do |scenario|
  $driver.close
end