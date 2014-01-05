# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe PercentFormatter do
  let(:data_reader) { NumberDataReader.new(:da, :type => :percent) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }
  let(:negative_number) { -12 }
  let(:number) { 12 }

  it "should format the number correctly" do
    pattern = data_reader.pattern(number)
    tokens = tokenizer.tokenize(pattern)
    formatter.format(tokens, number).should == "12 %"
  end

  it "should format negative numbers correctly" do
    pattern = data_reader.pattern(negative_number)
    tokens = tokenizer.tokenize(pattern)
    formatter.format(tokens, negative_number).should == "-12 %"
  end

  it "should respect the :precision option" do
    pattern = data_reader.pattern(negative_number)
    tokens = tokenizer.tokenize(pattern)
    formatter.format(tokens, negative_number, :precision => 3).should match_normalized("-12,000 %")
  end
end