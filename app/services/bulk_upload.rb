require 'csv'

module BulkUpload
  class BulkUploadError < StandardError; end

  def self.upload(params)
    csv = CSV.parse(params[:file].tempfile, headers: true, strip: true)
    validate_csv(csv)

  rescue CSV::MalformedCSVError
    raise(BulkUploadError, "The CSV you uploaded is malformed. Please download the template and try again.")
  end

  # will raise BulkUploadError if the CSV isn't valid
  def self.validate_csv(csv)
    csv.each do |row|
      good_hash = {
        cosignment_id: row["Consignment"],
        good_type: row["Good Type"],
        name: row["Name"],
        source: row["Source"],
        destination: row["Destination"],
        entry_time: row["Entry Time"],
        exit_time: row["Exit Time"]
      }

      # return an error message if the CSV values are invalid
      good = Good.new(good_hash)
      raise(BulkUploadError, good.errors.first.full_message) unless good.valid?
    end
  end
end
