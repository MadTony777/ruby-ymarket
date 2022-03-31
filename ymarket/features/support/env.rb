require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'
require 'logger'
Dir['./features/step_definitions/pages/*.rb'].each { |path| require path }


$SELENIUM_TIMEOUT = 20
$WAIT = 20
$DRIVER_PATH = './features/support/drivers/chromedriver.exe'
$page = DefaultPage.new
$logger = Logger.new(STDOUT)
$wait = Selenium::WebDriver::Wait.new(:timeout => 15)