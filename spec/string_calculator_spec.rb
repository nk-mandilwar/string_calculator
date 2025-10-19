require "string_calculator"

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 when argument is an empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end

    it "raises ArgumentError when argument is nil" do
      expect { StringCalculator.add(nil) }
        .to raise_error(ArgumentError, "argument cannot be nil")
    end

    it "raises ArgumentError when argument is not a String" do
      expect { StringCalculator.add(123) }
        .to raise_error(ArgumentError, "argument must be a String")
      expect { StringCalculator.add([1, 2, 3]) }
        .to raise_error(ArgumentError, "argument must be a String")
    end

    it "returns the same number when argument string contain single number" do
      expect(StringCalculator.add("50")).to eq(50)
    end

    it "returns the sum of comma separated numbers given in the argument" do
      expect(StringCalculator.add("50,10")).to eq(60)
    end

    it "supports new lines between numbers" do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it "supports custom delimiters defined with //;\n syntax" do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it "raises an error for negative numbers and lists them" do
      expect { StringCalculator.add("1,-2,3,-5") }
        .to raise_error("negatives not allowed: -2, -5")
    end

    it "ignores numbers greater than 1000" do
      expect(StringCalculator.add("2,1001")).to eq(2)
    end

    it "supports delimiters of any length" do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it "supports multiple delimiters" do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
    end

    it "supports multiple delimiters of variable length" do
      expect(StringCalculator.add("//[***][%%]\n1***2%%3")).to eq(6)
    end

    it "raises error when input contains invalid characters" do
      expect { StringCalculator.add("1,a,3") }.to raise_error(ArgumentError, "input contains invalid characters")
    end

    it "raises error for invalid characters even with custom delimiter" do
      expect { StringCalculator.add("//;\n1;2;x") }.to raise_error(ArgumentError, "input contains invalid characters")
    end

    it "raises error when invalid symbol appears with multi-character delimiter" do
      expect { StringCalculator.add("//[***]\n1***2,3") }.to raise_error(ArgumentError, "input contains invalid characters")
    end

    it "raises an error if '-' is used as a delimiter" do
      expect {
        StringCalculator.add("//[-]\n1-2-3")
      }.to raise_error(ArgumentError, "invalid delimiter: '-' cannot be used as it conflicts with negative numbers")
    end
  end
end
