require 'rails_helper'

RSpec.describe 'Shops', type: :request do
  describe 'POST /buy' do
    let!(:card) { FactoryBot.create(:card) }

    context 'when user not spend bonuses' do
      let!(:was_user_bonuses) { card.bonuses }
      before { post buy_api_v1_shop_path(card.shop.id), params: params, as: :json }

      context 'when amount more or equal then 100' do
        let(:params) do
          {
            use_bonuses: false,
            amount: 500,
            user_id: "#{card.user.id}"
          }
        end

        it 'returns true success' do
          expect(json_body['success']).to be true
        end

        it 'increases user bonuses' do
          expect(json_body['data']['remaining_bonus']).to eq(505)
        end
        
        it 'not changes amount_due' do
          expect(json_body['data']['amount_due']).to eq(500)
        end
      end

      context 'when amount less than 100' do
        let(:params) do
          {
            use_bonuses: false,
            amount: 90,
            user_id: "#{card.user.id}"
          }
        end

        it 'returns true success' do
          expect(json_body['success']).to be true
        end

        it 'not increase user bonuses' do
          expect(json_body['data']['remaining_bonus']).to eq(was_user_bonuses)
        end

        it 'not changes amount_due' do
          expect(json_body['data']['amount_due']).to eq(90)
        end
      end
    end

    context 'when user spends bonuses' do
      context 'when negative_balance option is false' do
        context 'when user has not bonuses' do
          before { card.update(bonuses: 0) }
          before { post buy_api_v1_shop_path(card.shop.id), params: params, as: :json }
          let(:params) do
            {
              use_bonuses: true,
              amount: 500,
              user_id: "#{card.user.id}"
            }
          end

          it 'returns true success' do
            expect(json_body['success']).to be true
          end

          it 'returns 0 remaining_bonus' do
            expect(json_body['data']['remaining_bonus']).to eq(0)
          end

          it 'returns full amount_due' do
            expect(json_body['data']['amount_due']).to eq(500)
          end
        end

        context 'when user has bonuses' do
          before { post buy_api_v1_shop_path(card.shop.id), params: params, as: :json }

          context 'when amount more or equal then user has bonuses' do
            let(:params) do
              {
                use_bonuses: true,
                amount: 850,
                user_id: "#{card.user.id}"
              }
            end

            it 'returns true success' do
              expect(json_body['success']).to be true
            end

            it 'returns some amount_due' do
              expect(json_body['data']['amount_due']).to eq(350)
            end

            it 'returns 0 remaining_bonus' do
              expect(json_body['data']['remaining_bonus']).to eq(0)
            end
          end

          context 'when amount less then user has bonuses' do
            let(:params) do
              {
                use_bonuses: true,
                amount: 170,
                user_id: "#{card.user.id}"
              }
            end

            it 'returns true success' do
              expect(json_body['success']).to be true
            end

            it 'returns 0 amount_due' do
              expect(json_body['data']['amount_due']).to eq(0)
            end

            it 'returns some remaining_bonus' do
              expect(json_body['data']['remaining_bonus']).to eq(330)
            end
          end
        end
      end

      context 'when negative_balance option is true' do
        let(:another_shop) { FactoryBot.create(:shop) }
        let!(:another_card) { FactoryBot.create(:card, shop_id: another_shop.id, user_id: card.user.id) }
        before do
          card.user.update(negative_balance: true)
          post buy_api_v1_shop_path(card.shop.id), params: params, as: :json
        end

        context 'when user has bonuses' do
          let(:params) do
            {
              use_bonuses: true,
              amount: 850,
              user_id: "#{card.user.id}"
            }
          end

          it 'returns success true' do
            expect(json_body['success']).to be true
          end

          it 'spends bonuses from card' do
            expect(json_body['data']['remaining_bonus']).to eq(-350)
          end

          it 'returns some amount_due' do
            expect(json_body['data']['amount_due']).to eq(0)
          end
        end

        context 'when user has bonusess only on another card' do
          before { card.update(bonuses: 0)}

          it 'returns success true' do
            expect(json_body['success']).to be true
          end

          it 'spends bonuses from card' do
            expect(json_body['data']['remaining_bonus']).to eq(-500)
          end

          it 'returns some amount_due' do
            expect(json_body['data']['amount_due']).to eq(350)
          end
        end

        context 'when user has not bonuses on all cards' do
          before do
            card.update(bonuses: 0)
            another_card.update(bonuses: 0)
          end

          it 'returns success true' do
            expect(json_body['success']).to be true
          end

          it 'not spends bonuses from card' do
            expect(json_body['data']['remaining_bonus']).to eq(0)
          end

          it 'not changes amount_due' do
            expect(json_body['data']['amount_due']).to eq(850)
          end
        end
      end
    end
  end
end
