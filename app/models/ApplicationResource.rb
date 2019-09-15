class ApplicationResource < ActiveResource::Base

  def id
    self._id.attributes[:$oid].to_s if respond_to?(:_id)
  end

  def include_root_in_json
    true
  end

  # def post()
end