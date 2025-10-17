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
  end
end
