; extends

(pair
  key: (property_identifier) @property
  value: (_) @_value
  (#not-kind-eq? @_value "arrow_function" "function_expression"))
