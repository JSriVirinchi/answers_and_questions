class Question < ApplicationRecord
	belongs_to :questionpaper
	validates :marks, presence: {message: 'should not be empty'}
end