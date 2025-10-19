class StringCalculator
  def self.add(numbers)
    validate_input(numbers)
    return 0 if numbers.empty?

    delimiter, numbers = extract_delimiter(numbers)

    tokens = numbers.split(delimiter).map(&:strip)
    validate_tokens!(tokens)

    nums = tokens.map(&:to_i)
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
    [parse_header_delimiter(header), numbers]
  end

  def self.parse_header_delimiter(header)
    if header.include?("-")
      raise ArgumentError, "invalid delimiter: '-' cannot be used as it conflicts with negative numbers"
    end

    if header.match(%r{//\[(.+)\]})
      delimiters = header.scan(%r{\[(.*?)\]}).flatten.map { |d| Regexp.escape(d) }
      Regexp.new(delimiters.join("|"))
    else
      Regexp.new(Regexp.escape(header[2]))
    end
  end

  def self.validate_tokens!(tokens)
    unless tokens.all? { |t| t.match?(/\A-?\d+\z/) }
      raise ArgumentError, "input contains invalid characters or partial delimiters"
    end
  end

  def self.check_for_negatives(nums)
    negatives = nums.select(&:negative?)
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end
end
