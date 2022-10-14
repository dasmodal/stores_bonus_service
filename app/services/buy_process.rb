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
        spend_bonuses()
      else
        accumulate_bonuses(card, buy_info['amount'])
      end

    prepare_response_json(buy_result)
  end

  private

  def spend_bonuses()
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

  def prepare_response_json(buy_result)
    data = { 'amount_due': "#{buy_result[1]}", 'remaining_bonus': "#{buy_result[0]}" }

    {
      'success': true, 'data': {
      'amount_due': buy_result[1],
      'remaining_bonus': buy_result[0]
      }
    }
  end
end
