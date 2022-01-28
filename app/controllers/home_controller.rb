class HomeController < ApplicationController
  def index
    # require 'net/http'
    # require 'json'
    # require 'uri'

    # @url = URI.parse("https://api.ambeedata.com/latest/by-postal-code?postalCode=560020&countryCode=IN")
    # http = Net::HTTP.new(@url.host, @url.port)
    # @request = Net::HTTP::Get.new(@url.request_uri)
    # # @request.add_field("Content-type","application/json")
    # # @request.add_field("x-api-key","61e70bcd059bff38dfaecabaffd88f626d07470ac48dcc27c33a39b59ceec429")
    # @request["Content-type"] = "application/json"
    # @request["x-api-key"] = "61e70bcd059bff38dfaecabaffd88f626d07470ac48dcc27c33a39b59ceec429"
    # puts @request
    # response = http.request(@request)
    # puts response
    # @output = JSON.parse(@request)
    # puts @output

    @find = Faraday.get('https://api.ambeedata.com/latest/by-postal-code?postalCode=400001&countryCode=IN') do |req|
      req.headers['x-api-key'] = '61e70bcd059bff38dfaecabaffd88f626d07470ac48dcc27c33a39b59ceec429'
    end
    @output = JSON.parse(@find.body)

    if @output['data'] == []
      @final = @output['message'].upcase
    else
      @final = @output['stations'][0]['AQI']
    end

    puts @final
    if @final == []
      @final_color = "gray"
      @description = "Please try again later."
    else
      case(@final)
        when 301..500
          @final_color = "maroon"
          @description = "Health warning of emergency conditions: everyone is more likely to be affected."
        when 201..300
          @final_color = "purple"
          @description = "Health alert: The risk of health effects is increased for everyone."
        when 151..200
          @final_color = "red"
          @description = "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
        when 101..150
          @final_color = "orange"
          @description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
        when 51..100
          @final_color = "yellow"
          @description = "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
        else
          @final_color = "green"
          @description = "Air quality is satisfactory, and air pollution poses little or no risk."
      end
    end
    puts @final_color
  end

  def zipcode
    @code = params[:zipcode]
    if params[:zipcode] == ""
      @code = "You forget to enter zipcode"
    end
  end
end
