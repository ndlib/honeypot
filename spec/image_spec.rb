require 'spec_helper'

require File.dirname(__FILE__) + '/../app/image.rb'

describe Image do

  [:filename, :width, :height, :path, :uri, :type].each do |attr|
    it "has the field, #{attr}" do
      expect(subject).to respond_to attr
    end
  end

  it "looks up the width from the file"

  it "looks up the height from the file"

  it "looks up the type from the file"

end
