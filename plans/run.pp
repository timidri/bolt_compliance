plan bolt_compliance::run(
  Array[String[1]] $controls,
  TargetSpec $nodes,
) {

  notice($controls)

  $controls.each | $control | {
    notice("Running control: ${control}")
    $result = run_task("bolt_compliance::cis_rhel7_${control}", $nodes)
    notice("Result for control ${control}: ${result}")
  #   $g_benchmark='CIS_RHEL7'
  #   $g_token='66a4327c-5db6-4fdb-97a1-9fdafcd193e1'
  #   $g_splunk_endpoint='https://splunk.slice.puppetlabs.net:8088/services/collector'

  #   $result.each | $r | {
  #     $sts=send_to_splunk($r['body'], $g_splunk_endpoint,  $g_token, true)
  #   }
  }
}
