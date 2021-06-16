require 'rails_helper'

RSpec.describe SystemRequirement, type: :model do
  it { is_expected.to validate_presence_of(:video_board) }
  it { is_expected.to validate_presence_of(:storage) }
  it { is_expected.to validate_presence_of(:memory) }
  it { is_expected.to validate_presence_of(:processor) }
  it { is_expected.to validate_presence_of(:os) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it {is_expected.to have_many(:games).dependent(:destroy)}

  it_behaves_like "name searchable concern", :system_requirement
  it_behaves_like "paginatable concern", :system_requirement
end
