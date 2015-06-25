# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  birth_date  :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
