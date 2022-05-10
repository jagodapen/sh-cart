class ShoppingListEmail < ApplicationRecord
  belongs_to :shopping_list
  # rubocop:disable Layout:LineLength
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # rubocop:enable Layout:LineLength
  validates :recipient, format: { with: VALID_EMAIL_REGEX,
                                  message: 'incorrect email adress format' }
  validates :send_date, comparison: { greater_than: Date.today,
                                      message: 'the date must be in the future' }

  enum :file_format, { xlsx: 0, csv: 1, pdf: 2 }
end
