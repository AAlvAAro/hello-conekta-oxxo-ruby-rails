class CheckoutsController < ApplicationController
  def index
  end

  def charge
    begin
      @charge = Conekta::Charge.create({
        amount: params['chargeInCents'],
        currency: "MXN",
        description: "Pizza Delivery at test",
        reference_id: "001-id-test",
        cash: {
          type: 'oxxo'
        }
      })
    rescue Conekta::ValidationError => e
      puts e.message_to_purchaser
      #alguno de los parámetros fueron inválidos
    rescue Conekta::ProcessingError => e
      puts e.message_to_purchaser
      #la tarjeta no pudo ser procesada
    rescue Conekta::Error
      puts e.message_to_purchaser
      #un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
    end
  end
end
