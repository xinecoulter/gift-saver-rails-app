class RecipientsController < ApplicationController
  def show
    @recipient = Recipient.find(params[:id])
  end
end