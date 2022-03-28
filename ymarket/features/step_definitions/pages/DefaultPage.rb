require 'page-object'
require 'selenium-webdriver'
require 'timeout'

class DefaultPage

  def open_url(url)
    $driver.get url
    anti_robot
  end

  def anti_robot
    if element_exist(xpath: "//*[contains(text(), 'Подтвердите, что запросы отправляли вы, а не робот')]")
      click(class: 'CheckboxCaptcha-Button')
    end
  end

  # Поиск элемента по локатору
  def find_element(by)
    sleep(0.1)
    $driver.find_element(get_locator(by))
  end

  # Поиск элементов по локатору
  def find_elements(by)
    $driver.find_elements(get_locator(by))
  end

  def click(by)
    $driver.action.move_to(find_element(by)).click.perform
    sleep(0.1)
    anti_robot
  end

  def send_keys(keys, by)
    find_element(by).send_keys(keys)
  end

  def quit_page
    $driver.quit
  end

  def close_tab
    $driver.close
  end

  def switch_last_tab
    sleep(0.1)
    $driver.switch_to.window($driver.window_handles.last)
  end

  def switch_first_tab
    $driver.switch_to.window($driver.window_handles.first)
  end


  # Существует ли элемент по локатору (возвращает true/false)
  def element_exist(by)
    $driver.manage.timeouts.implicit_wait = 0
    exist = find_elements(get_locator(by)).count > 0 ? true : false
    $driver.manage.timeouts.implicit_wait = 15
    exist
  end

  # Виден ли элемент по локатору (возвращает true/false)
  def element_visible(by)
    element_exist(by) ? find_element(by).displayed? : false
  end

  # Очистить текст элемента по локатору
  def clear_element(by)
    find_element(by).clear
  end

  # Получить локатор элемента в зависимости от входных данных
  def get_locator(by)
    case by
    when Hash
      return by
    when String
      return $page.get_value(by)
    end
  end

  def page_loading
    element_exist(css: "[aria-label='Загрузка...']") ? false : true
  end

  # Заменить текущую страницу
  def change_page_to(page)
    $page = case page
            when 'Main'
              MainPage.new
            when 'Filter'
              FilterPage.new
            when 'Product'
              ProductPage.new
            else
              DefaultPage.new
            end
  end
end