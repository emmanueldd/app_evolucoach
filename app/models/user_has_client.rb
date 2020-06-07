# bigint "user_id"
# bigint "client_id"
# bigint "lead_id"
# boolean "has_buy", default: false
# datetime "created_at", null: false
# datetime "updated_at", null: false

class UserHasClient < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :lead, optional: true
  has_many :crm_comments
  has_many :programs
  before_save :set_date

  scope :leads, -> { where.not(lead: nil) }
  scope :clients, -> { where.not(client: nil) }
  scope :paying_clients, -> { where.not(client: nil).where(has_buy: false) }

  def set_date
    self.lead_at = DateTime.now if lead_id_changed? && lead.present?
    self.client_at = DateTime.now if client_id_changed? && client.present?
  end

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
