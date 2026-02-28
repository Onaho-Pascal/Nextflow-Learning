#!/usr/bin/env nextflow

process greeting {
    input:
        val greeting
    output:
        path "${greeting}_output.txt"
    script:
    " " "
    echo '${greeting}' > '${greeting}_output.txt'
}  " " "

process upper {
    input:
        val input_file
    output:
        path "Upper${input_file}"
    script:
    " " "
    cat '${input_fle}' | tr '[a-z]' '[A-Z]' > 'Upper${input_file}'
}   " " "

workflow {
    main:
        greeting_ch = channel.fromPath('data/greetings.csv)
                    .splitCsv()
     greeting(greeting_ch)
     upper(greeting.out)

   publish:
          first_output = greeting.out
          second_output = upper.out
}

output {
     first_output { 
                path "hello-workflow"
                mode 'copy'
     }
     second_output {
                path "hello-workflow"
                mode 'copy'
    } 
}
