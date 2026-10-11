resource "grafana_asserts_log_config" "asserts_log_configs" {
  for_each = var.asserts_log_configs

  data_source_uid                      = each.value.data_source_uid
  default_config                       = each.value.default_config
  name                                 = each.value.name
  priority                             = each.value.priority
  entity_property_to_log_label_mapping = each.value.entity_property_to_log_label_mapping
  error_label                          = each.value.error_label
  filter_by_span_id                    = each.value.filter_by_span_id
  filter_by_trace_id                   = each.value.filter_by_trace_id

  dynamic "match" {
    for_each = each.value.match != null ? each.value.match : []
    content {
      op       = match.value.op
      property = match.value.property
      values   = match.value.values
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

