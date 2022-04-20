Before do |scenario|
  Selenium::WebDriver::Chrome::Service.driver_path = $DRIVER_PATH
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.timeouts.implicit_wait = ($SELENIUM_TIMEOUT)
  $driver.manage.window.maximize

end

After do |scenario|
  $driver ? $driver.close : error('Something went wrong.')
end


AfterStep do |scenario|
  $logger.info('current url is: ' + $driver.current_url)
  if scenario.failed?
    # encoded_img = $driver.screenshot_as(:base64)
    embed("data:image/png;base64,#{$encoded_img}",'image/png')
  end
end


