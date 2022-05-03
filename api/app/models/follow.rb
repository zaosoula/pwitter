class Follow < ApplicationRecord
  belongs_to :source, foreign_key: :source_id, class_name: "User"
  belongs_to :target, foreign_key: :target_id, class_name: "User"
end
