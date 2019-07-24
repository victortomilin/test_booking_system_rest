# frozen_string_literal: true

module ResponseHelper
  def json_body(response)
    JSON.parse(response.body, object_class: OpenStruct).data
  end

  def json_errors(response)
    JSON.parse(response.body, object_class: OpenStruct).errors
  end
end
