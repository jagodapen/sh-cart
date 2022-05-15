class ShoppingListEmailWorker
   include Sidekiq::Worker
   def emails
     @emails = ShoppingListEmail.where(was_send: false, send_date: Date.today)
   end

   def send_shopping_list(shopping_list)
     ShoppingListMailer.with(shopping_list: @shopping_list).shopping_list_email.deliver_now
   end
end
