class StringCalculator
  class << self
    def add(numbers)
      validate_input(numbers)
      return 0 if numbers.strip.empty?

      delimiters, numbers = extract_delimiters(numbers)
      validate_delimiters!(delimiters)

      tokens = tokenize(numbers, delimiters)
      validate_tokens!(tokens)

      values = tokens.map(&:to_i)
      check_negatives!(values)

      values.reject! { |n| n > 1000 }

      # Multiply only if *-delimiters exclusively used, else sum
      if delimiters.all? { |d| d.include?('*') }
        multiply_then_sum(numbers, delimiters)
      else
        values.sum
      end
    end

    private

    def validate_input(numbers)
      raise ArgumentError, "argument cannot be nil" if numbers.nil?
      raise ArgumentError, "argument must be a String" unless numbers.is_a?(String)
    end

    def validate_delimiters!(delimiters)
      if delimiters.include?('-')
        raise ArgumentError, "invalid delimiter: '-' cannot be used as it conflicts with negative numbers"
      end
    end

    def validate_tokens!(tokens)
      tokens.each do |token|
        next if token.strip.empty?
        unless token.strip.match?(/\A-?\d+\z/)
          raise ArgumentError, "input contains invalid characters or partial delimiters"
        end
      end
    end

    def check_negatives!(values)
      negatives = values.select(&:negative?)
      raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
    end

    def extract_delimiters(input)
      return [[",", "\n"], input] unless input.start_with?("//")

      header, body = input.split("\n", 2)
      delimiters = header.scan(/\[(.*?)\]/).flatten
      delimiters = [header[2]] if delimiters.empty?
      [delimiters, body]
    end

    def tokenize(numbers, delimiters)
      numbers.strip.split(Regexp.union(delimiters))
    end

    def multiply_then_sum(input, delimiters)
      mult_delims = delimiters.select { |d| d.include?('*') }
      add_delims  = delimiters - mult_delims

      add_parts = add_delims.empty? ? [input] : input.split(Regexp.union(add_delims))

      add_parts.sum do |part|
        nums = part.split(Regexp.union(mult_delims)).map(&:to_i).reject { |n| n > 1000 }
        nums.empty? ? 0 : nums.inject(:*)
      end
    end
  end
end
