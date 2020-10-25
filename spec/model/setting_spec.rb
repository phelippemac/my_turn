require 'rails_helper'

RSpec.describe Setting, type: :model do

  it 'A configuração é válida quando atende os valores padrão' do
    set = Setting.new
    set.save
    expect(set.interval).to eq(0.5)
    expect(set.max_usage).to eq(2.0)
    expect(set.initial_period).to eq(0.0)
    expect(set.last_period).to eq(24 - set.max_usage)
  end
end