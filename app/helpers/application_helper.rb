module ApplicationHelper
  def namespace
    return controller_path.split('/').first
    # namespace = controller_path.split('/').first
    # if namespace == 'devise' || namespace == 'learn'
    #   return namespace
    # else
    #   return 'root'
    # end
  end

  def status_to_str(status, date = nil)
    case status
    when 'paid'
      date_str = nil
      date_str = " le #{I18n.l(date)}" if date.present?
      "payé #{date_str} ✅"
    when 'failed'
      'échoué'
    when 'refunded'
      'remboursé'
    else
      'en attente'
    end
  end

  def get_age_from_date(birth_date)
    ((DateTime.now - birth_date).to_i / 365.25).to_i
  end

  def days_from_now(date)
    (date.to_date - Date.today).to_i
  end
  #
  # def price_to_sequence(number, sequence)
  #   number ||= 0
  #   "#{(number/ 100 / sequence).to_i}€"
  # end
end
