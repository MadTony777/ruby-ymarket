require 'selenium-webdriver'
require 'selenium/webdriver/common/action_builder'
require 'page-object'
require 'rspec-rails'


class Rspec < Step_definition

  describe Step_definition do
    it 'should return correct prices' do

      correct_prices.should eql(true)
    end

    it 'should return correct battery' do

      correct_battery.should eql(true)
    end

    it 'should save_url_filter_for_prices' do

      save_url_filter_for_prices.should eql()
    end

    it 'should save_url_filter_for_battery' do

      save_url_filter_for_battery.should eql()
    end

    it 'should cancel_battery_filter' do

      cancel_battery_filter.should eql()
    end

    it 'should to_smaller_than_from' do

      to_smaller_than_from.should eql()
    end

    it 'should battery_filter_all_pages' do

      battery_filter_all_pages.should eql()
    end

    it 'should price_filter_all_pages' do

      price_filter_all_pages.should eql()
    end

    it 'should clear_price_filter_from' do

      clear_price_filter_from.should eql()
    end

    it 'should clear_price_filter_to' do

      clear_price_filter_to.should eql()
    end

    it 'should filter_combination' do

      filter_combination.should eql()
    end




    it 'should previos_count_by_price' do

      previos_count_by_price.should eql()
    end

    it 'should previos_count_by_battery' do

      previos_count_by_battery.should eql()
    end

    it 'should price_field_valid' do

      price_field_valid.should eql()
    end

  end
end