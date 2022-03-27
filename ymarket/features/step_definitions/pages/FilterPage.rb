require 'page-object'


class FilterPage < DefaultPage


  def set_price_from(value)
    sleep(0.1)
    send_keys(value, id: 'glpricefrom')
  end

  def set_price_to(value)
    sleep(0.1)
    send_keys(value, id: 'glpriceto')
  end

  def set_battery_filter(accum)
    sleep(0.1)
    click(xpath: "//span[text()='#{accum} мА⋅ч']/parent::*/preceding::*[1]")
  end

  def next_page
    click(css: "[aria-label='Следующая страница']")
  end

  def get_products_prices
    find_elements(css: "[data-zone-name='price'] [data-autotest-currency] span:first-of-type")
  end

  def get_product_price
    find_element(css: "[data-zone-name='price'] [data-autotest-currency] span:first-of-type").text
  end

end

