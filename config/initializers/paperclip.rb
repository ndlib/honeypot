Paperclip.interpolates :namespace do |attachment, style|
  attachment.instance.namespace
end

Paperclip.interpolates :basename do |attachment, style|
  attachment.instance.filename
end
