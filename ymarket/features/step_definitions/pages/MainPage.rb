require 'page-object'

class MainPage < DefaultPage

  def select_search_category(category)
    $wait.until { element_visible(id: "catalogPopupButton")}
    click(id: "catalogPopupButton")
    $wait.until { element_visible(xpath: "//a[text()='Смартфоны']")}
    click(xpath: "//a[text()='#{category}']")
  end

  def open_category(url, category)
    open_url(url)
    select_search_category(category)
    sleep(0.1)
  end

end