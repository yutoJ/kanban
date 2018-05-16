require 'date'
namespace :check_card_deadline do
  desc 'TODO'
  task check_and_update: :environment do
    cards = Card.all
    today = Time.zone.today
    cards.each do |card|
      next if card.due_date.nil?

      if card.due_date == today
        ProjectLog.add_card_deadline_log(card)
      elsif card.due_date < today
        ProjectLog.add_card_overdue_log(card)
      end
    end
  end
end
