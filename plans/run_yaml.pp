plan bolt_compliance::run_yaml(
  Array[String[1]] $benchmarks,
  TargetSpec $nodes,
) {

  # we need to do this to enable fact gathering
  apply_prep($nodes)

  $default_task_args = loadyaml('splunk-config.yaml')

  notice("Running benchmarks: ${benchmarks}")

  $benchmarks.each | $benchmark | {
    $benchmark_data = loadyaml("${benchmark}.yaml")
    $controls = $benchmark_data['controls']
    $controls.each | $control | {
      notice("Running control: ${control['id']}")
      $bash_commands = $control['bash'][0]
      notice("Executing bash tests: \"${bash_commands}\"")
      $results = run_command($bash_commands, $nodes, '_catch_errors' => true)
      $results.each | $result | {
        notice("Result: ${result}")
        notice("Exit code: ${result['exit_code']}")
        notice("Stdout: ${result['stdout']}")
        notice("Name: ${control['name']}")
        notice("Description: ${control['description']}")
        notice("Rationale: ${control['rationale']}")
        notice("Impact: ${control['impact']}")

        $target_facts = facts($result.target)
        $result_hash = $result.value + {
          target => $result.target.name,
          benchmark => $benchmark_data['benchmark'],
          control => $control['id'],
          control_name => $control['name'],
          description => $control['description'],
          rationale => $control['rationale'],
          impact => $control['impact'],
          uptime => $target_facts['uptime'],
          compliant => $result['exit_code'] == 0,
          command => $bash_commands,
          output => $result['stdout']
        }
        $task_args = $default_task_args + { data => { event => $result_hash } }
        notice("task args: ${task_args}")
        $splunk_result = run_task('bolt_compliance::send_to_splunk', 'localhost', $task_args)

      }
    }
  }
}
