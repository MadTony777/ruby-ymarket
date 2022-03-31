require 'page-object'

class MainPage < DefaultPage

  def select_search_category(category)
    wait_until_visible(id: "catalogPopupButton")
    click(id: "catalogPopupButton")
    wait_until_visible(xpath: "//a[text()='#{category}']")
    click(xpath: "//a[text()='#{category}']")
  end

  def open_category(url, category)
    open_url(url)
    select_search_category(category)
    sleep(0.1)
  end

end