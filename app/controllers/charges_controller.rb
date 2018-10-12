class ChargesController < ApplicationController
  before_action :authorize

    def new
      @amount = params[:amount]
    end


    def create
      @amount = params[:amount].to_i
      # @amount = @amount.to_i/100
    
      # begin
      #   @amount = Float(@amount).round(2)
      # rescue
      #   flash[:error] = 'Charge not completed. Please enter a valid amount in AUD ($).'
      #   redirect_to new_charge_path
      #   return
      # end
    
      # @amount = (@amount * 100).to_i # Must be an integer!
    
      if @amount < 5
        flash[:error] = 'Charge not completed. Deposit amount must be at least $5.'
        redirect_to new_charge_path
        return
      end
    
      if Stripe::Charge.create(
        :amount =>  @amount*100,
        :currency => 'aud',
        :source => params[:stripeToken],
        :description => 'Credit Top Up'
      )
      
        if current_user.credit
          current_user.credit += @amount
        else
          current_user.credit = @amount
        end
        current_user.save!
      end
      
      
    
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
    end
end
    
    


