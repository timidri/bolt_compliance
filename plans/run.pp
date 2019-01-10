plan bolt_compliance::run(
  Array[String[1]] $controls,
  TargetSpec $nodes,
) {

  # we need to do this to enable fact gathering
  apply_prep($nodes)

  notice("Running controls: ${controls}")

  $default_task_args = loadyaml('splunk-config.yaml')

  $controls.each | $control | {
    notice("Running control: ${control}")

    $result = run_task("bolt_compliance::cis_rhel7_${control}", $nodes)
    notice("Result for control ${control}: ${result}")

    $result.each | $result | {
      $target_facts = facts($result.target)
      $result_hash = $result.value + { target => $result.target.name, control => $control, uptime => $target_facts['uptime'] }
      $task_args = $default_task_args + { data => { event => $result_hash } }
      notice("task args: ${task_args}")
      $splunk_result = run_task('bolt_compliance::send_to_splunk', 'localhost', $task_args)
      # notice("Result from Splunk: ${splunk_result}")
    }
  }
}
