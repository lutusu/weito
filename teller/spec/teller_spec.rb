require "spec_helper"

RSpec.describe Teller do
  it "add fp_call method to Object class" do
    expect(Object.new).to respond_to(:fp_call)
  end

  it "fp_call successfully invoke proc on callee" do
    add_one = ->(number){number+1}
    multiply_two = ->(number){number*2}
    expect(13.fp_call(add_one,multiply_two)).to eq(28)
  end

  it "successfully chain multiple procs" do
    add_one = ->(number){number+1}
    multiply_two = ->(number){number * 2}
    aka = Teller::Suger.chain(add_one,multiply_two)
    expect(aka.call(13)).to eq(28)
    expect(13.fp_call(aka)).to eq(28)
  end

end
