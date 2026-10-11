variable "asserts_log_configs" {
  description = <<EOT
Map of asserts_log_configs, attributes below
Required:
    - data_source_uid
    - default_config
    - name
    - priority
Optional:
    - entity_property_to_log_label_mapping
    - error_label
    - filter_by_span_id
    - filter_by_trace_id
    - match (block):
        - op (required)
        - property (required)
        - values (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    data_source_uid                      = string
    default_config                       = bool
    name                                 = string
    priority                             = number
    entity_property_to_log_label_mapping = optional(map(string))
    error_label                          = optional(string)
    filter_by_span_id                    = optional(bool)
    filter_by_trace_id                   = optional(bool)
    match = optional(list(object({
      op       = string
      property = string
      values   = optional(list(string))
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.asserts_log_configs : (
        v.priority >= 0 && v.priority <= 2147483647
      )
    ])
    error_message = "must be between 0 and 2147483647"
  }
}

