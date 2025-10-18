class StringCalculator
  def self.add(numbers)
    raise ArgumentError, "argument cannot be nil" if numbers.nil?
    raise ArgumentError, "argument must be a String" unless numbers.is_a?(String)
    return 0 if numbers.empty?

    delimiter = /,|\n/
    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)
      custom = header[2]
      delimiter = Regexp.new(Regexp.escape(custom))
    end

    numbers.split(delimiter).map(&:to_i).sum
  end
end
