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
    echo '${greeting}' > ${greeting}_output.txt
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
    // create a new channel
    greeting_ch = channel.fromPath(params.input)
        .splitCsv()
        .map { row -> row[0] }

    // emit a greeting
    sayHello(greeting_ch)

    publish:
    first_output = sayHello.out
}

output {
    first_output {
        path 'hello_channels'
        mode 'copy'
    }
}
