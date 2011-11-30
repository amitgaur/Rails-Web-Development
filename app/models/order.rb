class Order < ActiveRecord::Base
end
# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :text
#  email      :string(255)
#  pay_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

