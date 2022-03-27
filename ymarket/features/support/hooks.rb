
Before do |scenario|
  Selenium::WebDriver::Chrome::Service.driver_path = $DRIVER_PATH
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.timeouts.implicit_wait=($SELENIUM_TIMEOUT)
  $driver.manage.window.maximize

end

After do |scenario|
  $driver.close
end


AfterStep do |scenario|
  $logger.info('current url is: ' + $driver.current_url)
end