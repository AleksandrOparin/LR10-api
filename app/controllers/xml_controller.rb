class String
  def palindrome?
    self == reverse
  end
end

class Integer
  def palindrome?
    to_s.palindrome?
  end
end

class XmlController < ApplicationController
  before_action :parse_params, only: :index

  def index
    palindromes = 0.upto(Integer(@number))&.select { |number| number.palindrome? && (number**2).palindrome? }
    raise 'Число меньше нуля' if @number.to_i.negative?
  rescue ArgumentError
    @error = 'Некорректный ввод'
  rescue TypeError
    @error = 'Число не задано'
  rescue StandardError => e
    @error = e
  ensure
    data = unless @error.nil?
             { message: "#{@error} (InputNumber = #{@number})" }
           else
             palindromes.map { |elem| { elem: elem, square: elem**2 } }
           end

    respond_to do |format|
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end

  def parse_params
    @number = params[:InputNumber]
  end
end
