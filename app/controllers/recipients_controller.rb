class RecipientsController < ApplicationController
  def index
    @recipients = Recipient.all
  end
end