xml.root xmlns: "http://projecthdata.org/hdata/schemas/2009/06/core", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance" do
  xml.id @record.medical_record_number
  xml.version @record.version
  xml.created @record.created_at
  xml.lastModified @record.updated_at
  xml.extensions do
    xml.extension("http://projecthdata.org/c32", extensionId: 1)
    Record::Sections.each_with_index do |section_name, i|
      xml.extension("http://projecthdata.org/green/#{section_name}", extensionId: i + 2)
    end
    
  end
  xml.sections do
    xml.section(path: "c32", name: "C32", extensionId: 1)
    Record::Sections.each_with_index do |section_name, i|
      xml.section(path: section_feed_path(@record.medical_record_number, section_name), name: section_name.to_s.titleize, extensionId: i + 2)
    end
  end
end