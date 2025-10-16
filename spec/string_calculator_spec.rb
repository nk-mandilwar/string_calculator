require "string_calculator"

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 when argument is an empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end
  end

  it "raises ArgumentError when argument is nil" do
    expect { StringCalculator.add(nil) }
      .to raise_error(ArgumentError, "argument cannot be nil")
  end
end
