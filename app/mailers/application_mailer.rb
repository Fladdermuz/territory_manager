class ApplicationMailer < ActionMailer::Base
  default from: "system@cegestor.org"
  layout 'mailer'
end
