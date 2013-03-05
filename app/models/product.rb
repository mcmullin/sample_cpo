class Product < ActiveRecord::Base
  attr_accessible :item, :description, :retail, :cpo, :points, :category

  VALID_ITEM_REGEX = /\A\d{2,4}[-12RCWPHTSDBK]{0,5}\z/
  validates :item, presence: true, format: { with: VALID_ITEM_REGEX }, uniqueness: true
  validates :description, presence: true
  validates :retail, presence: true
  #validates :cpo, presence: true
  #validates :points, presence: true
  validates :category, presence: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    product = find_by_id(row["id"]) || new
	    product.attributes = row.to_hash.slice(*accessible_attributes)
	    product.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when '.csv' then Csv.new(file.path, nil, :ignore)
	  #when '.ods' then Openoffice.new(file.path, nil, :ignore)
	  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
	  when '.xlsx' then Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

end
