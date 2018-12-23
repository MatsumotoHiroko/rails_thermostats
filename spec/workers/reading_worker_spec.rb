require 'rails_helper'
RSpec.describe ReadingWorker, type: :worker do
  let(:reading){ build(:reading) }
  it { expect(ReadingWorker).to be_processed_in :reading }
end
