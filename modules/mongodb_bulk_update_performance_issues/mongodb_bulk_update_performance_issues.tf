resource "shoreline_notebook" "mongodb_bulk_update_performance_issues" {
  name       = "mongodb_bulk_update_performance_issues"
  data       = file("${path.module}/data/mongodb_bulk_update_performance_issues.json")
  depends_on = [shoreline_action.invoke_mongo_config_update]
}

resource "shoreline_file" "mongo_config_update" {
  name             = "mongo_config_update"
  input_file       = "${path.module}/data/mongo_config_update.sh"
  md5              = filemd5("${path.module}/data/mongo_config_update.sh")
  description      = "Review the MongoDB database configuration to ensure that it is optimized for bulk updates. This includes reviewing the system resources, such as CPU, memory, and disk space, and adjusting the configuration parameters accordingly."
  destination_path = "/tmp/mongo_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_mongo_config_update" {
  name        = "invoke_mongo_config_update"
  description = "Review the MongoDB database configuration to ensure that it is optimized for bulk updates. This includes reviewing the system resources, such as CPU, memory, and disk space, and adjusting the configuration parameters accordingly."
  command     = "`chmod +x /tmp/mongo_config_update.sh && /tmp/mongo_config_update.sh`"
  params      = ["MONGO_CONFIG_FILE","DISK_SPACE_LIMIT","MEMORY_LIMIT","CPU_LIMIT"]
  file_deps   = ["mongo_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.mongo_config_update]
}

