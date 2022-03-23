require 'page-object'
require 'selenium-webdriver'
require 'timeout'

class DefaultPage

  def open_url(url)
    $driver.get url
  end

  #Исполнить текст как руби код
  def get_value(var)
    eval("@@#{var}")
  end

  # Поиск элемента по локатору
  def find_element(by)
    sleep 0.1
    $driver.find_element(get_locator(by))
  end

  # Поиск элементов по локатору
  def find_elements(by)
    $driver.find_elements(get_locator(by))
  end

  def click(by)

    $driver.action.move_to(find_element(by)).click.perform
  end

  def excplicit_element_visible(by)
    timeout = $SELENIUM_TIMEOUT
    time_start = Time.now
    time_running = 0
    found = false
    while time_running.to_i < timeout
      found = element_visible(by)
        break if found
        sleep(1)
        time_running = Time.now - time_start
    end
    raise StandardError.new("Error: Element searching by #{by}  was not found") unless found
    found
  end

  def behind_click(by)
    $driver.action.move_to(find_element(by)).click.perform
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


  # Заменить текущую страницу
  def change_page_to(page)
    $report_url = nil
    case page
    when 'Авторизация'
      $page = LoginPage.new
    when 'Администрирование'
      $page = AdminPage.new
    when 'Лицензия'
      $page = LicensePage.new
    when 'Субъекты'
      $page = SubjectsPage.new
    when 'КИ'
      $page = KiPage.new
    when 'Экспорт'
      $page = ExportPage.new
    when 'Проверка'
      $page = CheckingPage.new
    when 'Импорт'
      $page = ImportPage.new
    when 'Журналы'
      $page = JournalPage.new
    when 'Задачи'
      $page = TasksPage.new
    when 'Отчеты'
      $page = ReportsPage.new
    when 'Групповой запрос'
      $page = GroupRequestPage.new
    when 'Запрос кредитной истории НБКИ'
      $page = RequestNbchPage.new
    when 'Запрос кредитной истории Эквифакс'
      $page = RequestEquifaxPage.new
    when 'Запрос кредитной истории ОКБ'
      $page = RequestExperianPage.new
    when 'Запрос в ЦККИ'
      $page = RequestCkkiPage.new
    when 'Мегафон'
      $page = MegafonPage.new
    when 'МТС'
      $page = MtsPage.new
    when 'Поиск в Право ру'
      $page = RequestPravoRuPage.new
    when 'Поиск компании по реквизитам'
      $page = CompaniesSearchPage.new
    when 'MailRu'
      $page = MailRuPage.new
    when 'Редактирование параметров автоэкспорта'
      $page = EditAutoexportPage.new
    when 'Редактирование профиля коннектора'
      $page = EditConnectorPage.new
    when 'Редактирование стратегии триггеров'
      $page = EditTriggersStrategy.new
    when 'Журнал работы коннекторов'
      $page = ConnectorJournalPage.new
      $report_url = $driver.current_url
    when 'Отчёт о кредитной истории'
      $page = ShowReportPage.new
      $report_url = $driver.current_url
    else
      $page = DefaultPage.new
    end
  end
end