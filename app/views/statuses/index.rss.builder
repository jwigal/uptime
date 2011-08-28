xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "assignr.com / Dropkick Studios System Status"
    xml.description "Lots of articles"
    xml.link statuses_url(:foprmat => "rss") 
    
    for status in @statuses
      xml.item do
        xml.title status.title
        xml.description status.description if status.description
        xml.pubDate status.created_at.to_s(:rfc822)
        xml.link statuses_url(status)
        xml.guid statuses_url(status)
      end
    end
  end
end