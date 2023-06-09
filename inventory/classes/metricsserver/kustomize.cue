parameters: {
    kapitan: {
        compile: [{
            output_path: "bases/metricsserver"
            input_type:  "external"
            output_type: "yaml"
            input_paths: ["cue"]
            env_vars: {
                OUTPUT_DIRECTORY: "\\${compiled_target_dir}"
            }
            args: ["-t source=${metricsserver:source}", "-t version=${metricsserver:version}", "-t requests_cpu=${metricsserver:resources:requests:cpu}", "gen_yaml", "./components/metricsserver"]
        }]
    }
}
