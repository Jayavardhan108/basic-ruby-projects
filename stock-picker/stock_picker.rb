# need to max_profit on a particular day
# max_profit_current_day = current_day_price - lowest_price_before_current_day
# maintain an array min_prices_index tracking index of lowest_price_day for current_day
# loop through prices array, find the pair which has max_profit

def pick_stock prices
  min_prices_index = Array.new(0,prices.length)
  min_prices_index[0] = 0
  prices[1..-1].each_with_index do |price, index| 
    min_prices_index[index] = prices[min_prices_index[index - 1]] < prices[index - 1] ? min_prices_index[index - 1] : index - 1
  end 

  profit_pair = [0, 0]
  profit = 0
  prices[1..-1].each_with_index do |price, index|
    curr_profit = prices[index] - prices[min_prices_index[index]] 
    if curr_profit > profit
      profit_pair = [min_prices_index[index], index] 
      profit = curr_profit
    end
  end
  profit_pair
end


p pick_stock [17,3,6,9,15,8,6,1,10]