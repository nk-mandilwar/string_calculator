class StringCalculator
  def self.add(numbers)
    raise ArgumentError, "argument cannot be nil" if numbers.nil?
    raise ArgumentError, "argument must be a String" unless numbers.is_a?(String)
    return 0 if numbers.empty?

    numbers.split(/,|\n/).map(&:to_i).sum
  end
end
