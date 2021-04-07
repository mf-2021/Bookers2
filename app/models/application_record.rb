class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  validates :word, presence: true
end
