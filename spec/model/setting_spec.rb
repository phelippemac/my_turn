require 'rails_helper'

RSpec.describe Setting, type: :model do

  it 'A configuração é válida quando atende os valores padrão' do
    set = Setting.new
    set.save
    expect(set.interval.to_f).to eq(1.0)
    expect(set.max_usage.to_f).to eq(1.0)
    expect(set.initial_period.to_f).to eq(6.0)
    expect(set.last_period.to_f).to eq(24 - set.max_usage)
  end
end