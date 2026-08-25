//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <location/location_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) location_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LocationPlugin");
  location_plugin_register_with_registrar(location_registrar);
}
