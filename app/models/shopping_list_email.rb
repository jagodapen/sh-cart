class ShoppingListEmail < ApplicationRecord
  belongs_to :shopping_list
  # rubocop:disable Layout:LineLength
  VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  # rubocop:enable Layout:LineLength
  validates :recipient, format: { with: VALID_EMAIL_REGEX,
                                  message: 'incorrect email adress format' }
  validates :send_date, comparison: { greater_than: Date.today,
                                      message: 'the date must be in the future' }

  enum :format {
                  xlsx: 0,
                  csv: 1,
                  pdf: 2,
                }
end
