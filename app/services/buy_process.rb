class BuyProcess
  def self.call(buy_info)
    new.call(buy_info)
  end

  def call(buy_info)
    card = Card.find_by(
      shop_id: buy_info['shop_id'],
      user_id: buy_info['user_id']
    )

    buy_result =
      if buy_info['use_bonuses']
        spend_bonuses(card, buy_info['amount'])
      else
        accumulate_bonuses(card, buy_info['amount'])
      end

    { 'amount_due': "#{buy_result[1]}", 'remaining_bonus': "#{buy_result[0]}" }
  end

  private

  def spend_bonuses(card, amount)
    if card.user.negative_balance
      sum_all_bonuses = card.user.card.pluck(:bonuses).sum

      if amount >= sum_all_bonuses
        new_bonuses = card.bonuses - sum_all_bonuses
        amount_due = amount - sum_all_bonuses
        card.update(bonuses: new_bonuses)

        [new_bonuses, amount_due]
      else
        new_bonuses = card.bonuses - amount
        card.update(bonuses: new_bonuses)

        [card.bonuses, 0]
      end
    else
      if amount >= card.bonuses
        amount_due = amount - card.bonuses
        card.update(bonuses: 0)

        [0, amount_due]
      else
        new_bonuses_value = card.bonuses - amount
        card.update(bonuses: new_bonuses_value)

        [card.bonuses, 0]
      end
    end
  end

  def accumulate_bonuses(card, amount)
    if amount < 100
      [card.bonuses, amount]
    else
      new_bonuses = card.bonuses + (amount * 0.01)
      card.update(bonuses: new_bonuses)

      [new_bonuses, amount]
    end
  end
end
