#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {
    input:
    val greeting

    output:
    path "${greeting}_output.txt"

    script:
    """
    echo '${greeting}' > '${greeting}_output.txt'
    """
}

process convertToUpper {

    input:
    path input_file

    output:
    path "UPPER-${input_file}"

    script:
    """
    cat '${input_file}' | tr '[a-z]' '[A-Z]' > 'UPPER-${input_file}'
    """
}

/*
 * Pipeline parameters
 */
params {
    input: Path = 'data/greetings.csv'
}

workflow {

    main:
    // create a channel for inputs from a CSV file
    greeting_ch = channel.fromPath(params.input)
                        .splitCsv()
                        .map { line -> line[0] }
    // emit a greeting
    sayHello(greeting_ch)
    convertToUpper(sayHello.out)

    publish:
    first_output = sayHello.out
    uppercased = convertToUpper.out
}

output {
    first_output {
        path 'hello_workflow'
        mode 'copy'
    }

    uppercased {
        path 'hello_workflow'
        mode 'copy'
    }
}
