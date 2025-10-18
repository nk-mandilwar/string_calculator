class StringCalculator
  def self.add(numbers)
    raise ArgumentError, "argument cannot be nil" if numbers.nil?
    raise ArgumentError, "argument must be a String" unless numbers.is_a?(String)
    return 0 if numbers.empty?

    delimiter = /,|\n/
    if numbers.start_with?("//")
      header, numbers = numbers.split("\n", 2)
      if header.match(%r{//\[(.+)\]})
        delimiters = header.scan(%r{\[(.*?)\]}).flatten.map { |d| Regexp.escape(d) }
        delimiter = Regexp.new(delimiters.join("|"))
      else
        custom = header[2..]
        delimiter = Regexp.new(Regexp.escape(custom))
      end
    end

    nums = numbers.split(delimiter).map(&:to_i)
    negatives = nums.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?

    nums.reject { |n| n > 1000 }.sum
  end
end
