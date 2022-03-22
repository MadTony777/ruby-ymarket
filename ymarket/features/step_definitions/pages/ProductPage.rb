require 'page-object'


class ProductPage < DefaultPage


  def get_accum_on_page
    capacity = find_element(xpath: "//*[contains(text(), ' мА·ч')]").text
    puts 'WATF: ' + capacity
    capacity = capacity.scan(/\d*/).reject(&:empty?)
    capacity[0]
  end

  def get_price_on_page
    find_element(xpath: "//*[contains(text(), '  ₽')]").text
  end
end