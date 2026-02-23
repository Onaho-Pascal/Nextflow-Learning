#!/usr/bin/env nextflow

process sayHello{
        input: val greeting

        output: path '${greeting}_output.txt'
    
        script:
             """
             echo ${greeting} > ${greeting}_output.txt
         
             """
}

workflow{

        main:
        greetings_array = ['Pascal', 'Daniel', 'Joshua']
        greeting_ch = channels.of(greetings_array)
                    .view {greeting -> 'Before Flatten: $greeting'}
                    .flatten()
                    .view {greeting -> 'After Flatten: $greeting'}
        sayHello(greeting_ch)

        publish:
        first_output = sayHello.out
}


output{
      
      first_output{
                  path 'Pascal'
                  mode 'copy'
      }
}
