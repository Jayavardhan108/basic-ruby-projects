
class Calculator
  
  def add(*args)
    args.reduce(0) { |sum, arg| sum + arg}
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)
    a / b
  end

  def subtract(a, b)
    a - b
  end
end
