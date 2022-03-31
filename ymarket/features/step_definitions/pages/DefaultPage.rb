require 'page-object'
require 'selenium-webdriver'
require 'timeout'

class DefaultPage

  def open_url(url)
    $driver.get url
    anti_robot
  end

  def get_url
    $driver.current_url
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

  def find_element_in_element(element, locator)
    sleep(0.1)
    element.find_element(get_locator(locator))
  end

  def wait_until_child_element_not_exist(element, locator)
    $driver.manage.timeouts.implicit_wait = 0
    begin
      element.find_element(get_locator(locator))
      false
    rescue Selenium::WebDriver::Error::NoSuchElementError
      true
    ensure
      $driver.manage.timeouts.implicit_wait = 0
    end
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

  # # Виден ли элемент по локатору (возвращает true/false)
  # def element_visible(by)
  #   element_exist(by) ? find_element(by).displayed? : false
  # end

  # Очистить текст элемента по локатору
  def clear_element(by)
    find_element(by).clear
  end

  # Получить локатор элемента в зависимости от входных данных
  def get_locator(by)
    case by
    when Hash
      by
    when String
      $page.get_value(by)
    end
  end


  def wait_until_visible(by)
    (0..$WAIT).each do
      if !element_exist(by)
        sleep(1)
      else
        break
      end
    end
    element_exist(by)
  end

  def wait_until_has_text(by)
    (0..$WAIT).each do
      if !element_exist(by) or find_element(by).text.empty?
        sleep(1)
      else
        break
      end
    end
    element_exist(by)
  end

  def wait_until_disappear(by)
    (0..$WAIT).each do
      if element_exist(by)
        sleep(1)
      else
        break
      end
    end
    !element_exist(by)
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