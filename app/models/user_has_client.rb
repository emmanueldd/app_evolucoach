# bigint "user_id"
# bigint "client_id"
# bigint "lead_id"
# boolean "is_client", default: false
# datetime "created_at", null: false
# datetime "updated_at", null: false

class UserHasClient < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :lead, optional: true

  def infos # shortcut
    client || lead
  end

  # def infos(attribute) # shortcut 2.0
  #   if client.present? && client.send(attribute).present?
  #     client.send(attribute)
  #   elsif lead.present? && lead.send(attribute).present?
  #     lead.send(attribute)
  #   else
  #     return ''
  #   end
  # end

end