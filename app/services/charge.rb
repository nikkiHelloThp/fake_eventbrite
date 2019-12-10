class Charge

	def perform(params)
	  # Amount in cents
	  @amount = params[:amount_in_cent]

	  customer = Stripe::Customer.create({
	    email: params[:stripeEmail],
	    source: params[:stripeToken],
	  })

	  charge = Stripe::Charge.create({
	    customer: customer.id,
	    amount: @amount,
	    description: 'Rails Stripe customer',
	    currency: 'usd',
	  })

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_event_attendance_path(@event.id)
	end
end