require 'csv'

module BulkUpload
  class BulkUploadError < StandardError; end

  def self.upload(params)
    csv = CSV.parse(params[:file].tempfile, headers: true, strip: true)

    # validate that the CSV is valid
    validate_csv(csv)

    # create/update the goods
    upsert_goods(csv)

  rescue CSV::MalformedCSVError
    raise(BulkUploadError, "The CSV you uploaded is malformed. Please download the template and try again.")
  end

  # will raise BulkUploadError if the CSV isn't valid
  def self.validate_csv(csv)
    csv.each do |row|
      good_hash = parse_row(row)

      # return an error message if the CSV values are invalid
      good =
        if Good.exists?(cosignment_id: good_hash[:cosignment_id])
          good = Good.find_by(cosignment_id: good_hash[:cosignment_id])
          good.assign_attributes(good_hash)
          good
        else
          Good.new(good_hash)
        end

      raise(BulkUploadError, good.errors.first.full_message) unless good.valid?
    end
  end

  def self.upsert_goods(csv)
    csv.each do |row|
      good_hash = parse_row(row)

      # return an error message if the CSV values are invalid
      good =
        if Good.exists?(cosignment_id: good_hash[:cosignment_id])
          good = Good.find_by(cosignment_id: good_hash[:cosignment_id])
          good.update(good_hash)
          good
        else
          Good.create(good_hash)
        end

      raise(BulkUploadError, good.errors.first.full_message) unless good.valid?
    end
  end

  def self.parse_row(row)
    {
      cosignment_id: row["Consignment"],
      good_type: row["Good Type"],
      name: row["Name"],
      source: row["Source"],
      destination: row["Destination"],
      entry_time: row["Entry Time"],
      exit_time: row["Exit Time"]
    }
  end
end
