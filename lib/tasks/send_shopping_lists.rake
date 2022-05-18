desc "Call ShoppingListEmailJob to filter emails and send shopping lists"

task send_shopping_lists: :environment do
  ShoppingListEmailJob.perform_now
end
