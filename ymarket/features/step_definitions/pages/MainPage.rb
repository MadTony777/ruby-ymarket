require 'page-object'

class MainPage < DefaultPage

  def select_search_category(category)
    # $driver.save_screenshot("./screen.png")
    $encoded_img = $driver.screenshot_as(:base64)
    wait_until_exist(id: "catalogPopupButton")
    click(id: "catalogPopupButton")
    wait_until_exist(xpath: "//a[text()='#{category}']")
    click(xpath: "//a[text()='#{category}']")
  end

  def open_category(url, category)
    open_url(url)
    select_search_category(category)
    sleep(0.1)
  end

end