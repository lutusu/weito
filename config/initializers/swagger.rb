if defined? GrapeSwaggerRails
  GrapeSwaggerRails.options.url      = '/api/swagger_doc.json'
  GrapeSwaggerRails.options.before_action_proc = proc {
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
    # if (version = request.query_parameters['version']).present?
    #   GrapeSwaggerRails.options.headers['Accept-Version'] = version
    # end
  }
  GrapeSwaggerRails.options.doc_expansion = 'list'
end