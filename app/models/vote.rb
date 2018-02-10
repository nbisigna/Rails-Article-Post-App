class Vote < ApplicationRecord
    belongs_to :post
    belongs_to :comments
end
