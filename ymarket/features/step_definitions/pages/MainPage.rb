require 'page-object'

class MainPage < DefaultPage

  def select_search_category(category)
    send_keys(category, id: "header-search")
    sleep(5)
    click(xpath: "//*[contains(text(), 'Найти')]")
    sleep(5)
    puts 'fall 1'
    click(xpath: "//*[contains(text(), 'Смартфоны')]")
  end

  def open_smart_category(url, category)
    open_url(url)
    select_search_category(category)
  end

end