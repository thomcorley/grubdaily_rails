class ContactFormMessage
  attr_accessor :name, :email, :message, :subscribe

  def initialize(name:, email:, message:, subscribe:)
    @name = name
    @email = email
    @message = message
    @subscribe = subscribe
  end

  # converts the raw data from the HTML form
  def subscribe?
    subscribe == "1"
  end
end
