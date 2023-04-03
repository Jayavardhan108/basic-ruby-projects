#spec/calculator_spec.rb
require './lib/calculator.rb'
describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5,2,3)).to eql(10)
    end
  end

  describe "#multiply" do
    it "returns the product of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(5,2)).to eql(10)
    end
  end

  describe "#divide" do
    it "returns the quotient of a divident divided by a divisor" do
      calculator = Calculator.new
      expect(calculator.divide(5,2)).to eql(2)
    end
  end

  describe "#subtract" do
    it "returns the difference of two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(5,2)).to eql(3)
    end
  end
end
