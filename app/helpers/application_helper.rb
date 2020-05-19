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

  # def price_to_currency(number)
  #   number ||= 0
  #   "#{number / 100}€"
  # end
  #
  # def price_to_sequence(number, sequence)
  #   number ||= 0
  #   "#{(number/ 100 / sequence).to_i}€"
  # end
end
