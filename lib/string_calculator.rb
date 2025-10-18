class StringCalculator
  def self.add(numbers)
    validate_input(numbers)
    return 0 if numbers.empty?

    delimiter, numbers = extract_delimiter(numbers)
    nums = parse_numbers(numbers, delimiter)

    check_for_negatives(nums)

    nums.reject { |n| n > 1000 }.sum
  end

  private

  def self.validate_input(numbers)
    raise ArgumentError, "argument cannot be nil" if numbers.nil?
    raise ArgumentError, "argument must be a String" unless numbers.is_a?(String)
  end

  def self.extract_delimiter(numbers)
    default_delimiter = /,|\n/

    return [default_delimiter, numbers] unless numbers.start_with?("//")

    header, numbers = numbers.split("\n", 2)
    delimiter = parse_header_delimiter(header)
    [delimiter, numbers]
  end

  def self.parse_header_delimiter(header)
    if header.match(%r{//\[(.+)\]})
      delimiters = header.scan(%r{\[(.*?)\]}).flatten.map { |d| Regexp.escape(d) }
      Regexp.new(delimiters.join("|"))
    else
      custom = header[2..]
      Regexp.new(Regexp.escape(custom))
    end
  end

  def self.parse_numbers(numbers, delimiter)
    numbers.split(delimiter).map(&:to_i)
  end

  def self.check_for_negatives(nums)
    negatives = nums.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end
end
